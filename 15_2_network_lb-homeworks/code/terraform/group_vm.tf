#Create group vm

resource "yandex_iam_service_account" "groupvm-sa" {
  name                  = var.groupvm_sa_name
}

resource "yandex_resourcemanager_folder_iam_member" "group-editor" {
  folder_id             = var.folder_id
  role                  = var.groupvm_editor_role
  member                = "serviceAccount:${yandex_iam_service_account.groupvm-sa.id}"
  depends_on            = [yandex_iam_service_account.groupvm-sa]
}

resource "yandex_compute_instance_group" "group_vm" {
  name                  = var.group_vm_resources[0].name
  folder_id             = var.folder_id
  service_account_id    = "${yandex_iam_service_account.groupvm-sa.id}"
  deletion_protection   = var.group_vm_deletion_protection
  depends_on            = [yandex_resourcemanager_folder_iam_member.group-editor]
  instance_template {
    platform_id         = var.group_vm_resources[0].platform_id  
    metadata            = local.metadata
    resources {
      cores             = var.group_vm_resources[0].cores
      memory            = var.group_vm_resources[0].memory
      core_fraction     = var.group_vm_resources[0].core_fraction
    }
  
  boot_disk {
    initialize_params {
      image_id          = var.group_vm_boot_disk[0].image_id
      type              = var.group_vm_boot_disk[0].type
      size              = var.group_vm_boot_disk[0].size
    }   
  }

  network_interface { 
    network_id          = "${yandex_vpc_network.develop.id}"
    subnet_ids          = ["${yandex_vpc_subnet.public.id}"]
    nat                 = var.group_vm_nat
  }

  scheduling_policy { 
    preemptible         = var.group_vm_preemptible
  }
}

  scale_policy {
    fixed_scale {
      size              = var.scale_policy_fixed_scale_size     # Количество ВМ в группе
    }
  }

  deploy_policy {
    max_unavailable     = var.deploy_policy_max_unavailable
    max_expansion       = var.deploy_policy_max_expansion
  }

  allocation_policy {
    zones               = [var.default_zone]
  }

  health_check {
    interval            = var.health_check_interval             # Интервал проверки состояния ВМ в секундах
    timeout             = var.health_check_timeout              # Время ожидания ответа от ВМ в секундах
    unhealthy_threshold = var.health_check_unhealthy_threshold  # Количество неудачных попыток до пометки ВМ как нездоровой
    tcp_options {
      port              = var.health_check_tcp_options_port
    }
  }

  load_balancer {
    target_group_name   = var.load_balancer_target_group_name
  }
}
