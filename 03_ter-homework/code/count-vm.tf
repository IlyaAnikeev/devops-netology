#Create 2 VM (web-1 & web-2)

data "yandex_compute_image" "web_vm_ubuntu" {
  family = var.web_vm_family
}

resource "yandex_compute_instance" "web_vm" {
  depends_on  = [yandex_compute_instance.db_vm]
  name        = "web-${count.index+1}"
  hostname    = "web-${count.index+1}"
  platform_id = var.web_vm_platform_id
  count       = var.web_vm_count

  resources {
    cores         = var.web_vm_cores
    memory        = var.web_vm_memory
    core_fraction = var.web_vm_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.web_vm_ubuntu.image_id
      type     = var.web_vm_type
      size     = var.web_vm_size
    }   
  }

  metadata     = var.ssh_public_key

  scheduling_policy { 
    preemptible = var.web_vm_preemptible 
  }

  network_interface { 
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = var.web_vm_nat
    security_group_ids = [
        yandex_vpc_security_group.example.id
    ]
  }
  allow_stopping_for_update = var.web_vm_allow_stopping_for_update
}