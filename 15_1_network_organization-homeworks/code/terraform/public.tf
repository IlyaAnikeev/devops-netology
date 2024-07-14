#Create vm public

data "yandex_compute_image" "public_os" {
  family = var.public_os
}

resource "yandex_compute_instance" "public" {
  name              = var.public_resources[0].public_name
  hostname          = var.public_resources[0].public_name
  platform_id       = var.public_resources[0].platform_id
  resources {
      cores         = var.public_resources[0].cores
      memory        = var.public_resources[0].memory
      core_fraction = var.public_resources[0].core_fraction
  }
  
  boot_disk {
    initialize_params {
      image_id      = var.public_boot_disk[0].image_id
      type          = var.public_boot_disk[0].type
      size          = var.public_boot_disk[0].size
    }   
  }

  metadata          = var.ssh_public_key

  scheduling_policy { 
    preemptible     = var.public_preemptible
  }

  network_interface { 
    subnet_id       = yandex_vpc_subnet.public.id
    nat             = var.public_nat
  }
  allow_stopping_for_update = var.public_allow_stopping_for_update
}