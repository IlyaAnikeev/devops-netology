#Create vm master

data "yandex_compute_image" "os_master" {
  family = var.os_master
}

resource "yandex_compute_instance" "master" {
  name              = "${var.master_resources[0].master_name}-${count.index+1}"
  hostname          = "${var.master_resources[0].master_name}-${count.index+1}"
  count             = var.master_resources[0].count_vm
  platform_id       = var.master_resources[0].platform_id
  resources {
      cores         = var.master_resources[0].cpu
      memory        = var.master_resources[0].ram
      core_fraction = var.master_resources[0].core_fraction
  }
  
  boot_disk {
    initialize_params {
      image_id      = data.yandex_compute_image.os_master.image_id
      type          = var.master_type
      size          = var.master_resources[0].disk_size
    }   
  }

  metadata     = {
    serial-port-enable = var.serial_port_master
    ssh-keys           = "ubuntu:${local.ssh-keys}"
    user-data          = data.template_file.cloudinit.rendered
  }

  scheduling_policy { 
    preemptible     = var.master_preemptible
  }

  network_interface { 
    subnet_id          = yandex_vpc_subnet.devops-subnet-1.id
    nat                = var.master_nat
  }
  allow_stopping_for_update = var.master_allow_stopping_for_update
}