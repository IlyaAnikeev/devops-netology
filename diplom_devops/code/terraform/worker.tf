#Create vm worker

data "yandex_compute_image" "os_worker" {
  family = var.os_worker
}

resource "yandex_compute_instance" "worker" {
  depends_on = [yandex_compute_instance.master]
  name              = "${var.worker_resources[0].worker_name}-${count.index+1}"
  hostname          = "${var.worker_resources[0].worker_name}-${count.index+1}"
  count             = var.worker_resources[0].count_vm
  platform_id       = var.worker_resources[0].platform_id
  resources {
      cores         = var.worker_resources[0].cpu
      memory        = var.worker_resources[0].ram
      core_fraction = var.worker_resources[0].core_fraction
  }
  
  boot_disk {
    initialize_params {
      image_id      = data.yandex_compute_image.os_worker.image_id
      type          = var.worker_type
      size          = var.worker_resources[0].disk_size
    }   
  }

  metadata     = {
    serial-port-enable = var.serial_port_worker
    ssh-keys           = "ubuntu:${local.ssh-keys}"
    user-data          = data.template_file.cloudinit.rendered
  }

  scheduling_policy { 
    preemptible     = var.worker_preemptible
  }

  network_interface { 
    subnet_id          = yandex_vpc_subnet.devops-subnet-2.id
    nat                = var.worker_nat
  }
  allow_stopping_for_update = var.worker_allow_stopping_for_update
}