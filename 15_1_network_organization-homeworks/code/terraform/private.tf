#Create vm private

data "yandex_compute_image" "private_os" {
  family = var.private_os
}

resource "yandex_compute_instance" "private" {
  name              = var.private_resources[0].private_name
  hostname          = var.private_resources[0].private_name
  platform_id       = var.private_resources[0].platform_id
  resources {
      cores         = var.private_resources[0].cores
      memory        = var.private_resources[0].memory
      core_fraction = var.private_resources[0].core_fraction
  }
  
  boot_disk {
    initialize_params {
      image_id      = var.private_boot_disk[0].image_id
      type          = var.private_boot_disk[0].type
      size          = var.private_boot_disk[0].size
    }   
  }

  metadata          = var.ssh_public_key

  scheduling_policy { 
    preemptible     = var.private_preemptible
  }

  network_interface { 
    subnet_id       = yandex_vpc_subnet.private.id
    nat             = var.private_nat
  }
  allow_stopping_for_update = var.private_allow_stopping_for_update
}