#Create vm nat

data "yandex_compute_image" "nat_os" {
  family = var.nat_os
}

resource "yandex_compute_instance" "nat" {
  name              = var.nat_resources[0].nat_name
  hostname          = var.nat_resources[0].nat_name
  platform_id       = var.nat_resources[0].platform_id
  resources {
      cores         = var.nat_resources[0].cores
      memory        = var.nat_resources[0].memory
      core_fraction = var.nat_resources[0].core_fraction
  }
  
  boot_disk {
    initialize_params {
      image_id      = var.nat_boot_disk[0].image_id
      type          = var.nat_boot_disk[0].type
      size          = var.nat_boot_disk[0].size
    }   
  }

  metadata          = var.ssh_public_key

  scheduling_policy { 
    preemptible     = var.nat_preemptible
  }

  network_interface { 
    subnet_id       = yandex_vpc_subnet.public.id
    nat             = var.nat_instance_nat
    ip_address      = var.nat_instance_ip_address
  }
  allow_stopping_for_update = var.nat_allow_stopping_for_update
}