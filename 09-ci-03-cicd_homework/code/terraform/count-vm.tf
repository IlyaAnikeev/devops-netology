data "yandex_compute_image" "web_vm_centos" {
  family = var.web_vm_family
}

resource "yandex_compute_instance" "web_vm" {
  for_each          = {for web_vm in var.web_vm_resources: web_vm.web_vm_name => web_vm}
  name              = each.value.web_vm_name
  hostname          = each.value.web_vm_name
  platform_id       = each.value.platform_id
  resources {
      cores         = each.value.cpu
      memory        = each.value.ram
      core_fraction = each.value.core_fraction
  }
  
  boot_disk {
    initialize_params {
      image_id      = data.yandex_compute_image.web_vm_centos.image_id
      type          = var.web_vm_type
      size          = each.value.disk
    }   
  }

  metadata          = var.ssh_public_key

  scheduling_policy { 
    preemptible     = var.web_vm_preemptible
  }

  network_interface { 
    subnet_id       = yandex_vpc_subnet.develop.id
    nat             = var.web_vm_nat
  }
  allow_stopping_for_update = var.web_vm_allow_stopping_for_update
}
