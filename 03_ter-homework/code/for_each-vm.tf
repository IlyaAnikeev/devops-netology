#Create 2 VM (main & replica)

data "yandex_compute_image" "db_vm_ubuntu" {
  family = var.db_vm_family
}

resource "yandex_compute_instance" "db_vm" {
  for_each          = {for db_vm in var.db_vm_resources: db_vm.db_vm_name => db_vm}
  name              = each.value.db_vm_name
  hostname          = each.value.db_vm_name
  platform_id       = each.value.platform_id
  resources {
      cores         = each.value.cpu
      memory        = each.value.ram
      core_fraction = each.value.core_fraction
  }
  
  boot_disk {
    initialize_params {
      image_id      = data.yandex_compute_image.db_vm_ubuntu.image_id
      type          = var.db_vm_type
      size          = each.value.disk
    }   
  }

  metadata     = var.ssh_public_key

  scheduling_policy { 
    preemptible     = var.db_vm_preemptible
  }

  network_interface { 
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = var.db_vm_nat
    security_group_ids = [
        yandex_vpc_security_group.example.id
    ]
  }
  allow_stopping_for_update = var.web_vm_allow_stopping_for_update
}