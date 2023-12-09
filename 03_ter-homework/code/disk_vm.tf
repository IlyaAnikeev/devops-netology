data "yandex_compute_image" "storage_vm_ubuntu" {
  family = var.storage_vm_family
}

resource "yandex_compute_disk" "disks" {
  name       = "disk-${count.index+1}"
  type       = var.disk_vm_type
  zone       = var.disk_vm_zone
  size       = var.disk_vm_size
  count      = var.disk_vm_count
}

resource "yandex_compute_instance" "storage" {
  name     = var.storage_vm_name
  hostname = var.storage_vm_hostname
  zone     = var.storage_vm_zone

  resources {
    cores         = var.storage_vm_cores
    memory        = var.storage_vm_memory
    core_fraction = var.storage_vm_core_fraction
  }


  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.storage_vm_ubuntu.image_id
      type     = var.storage_vm_type
      size     = var.storage_vm_size
    }   
  }

  metadata     = var.ssh_public_key

  scheduling_policy { 
    preemptible = var.storage_vm_preemptible
  }

  network_interface { 
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = var.storage_vm_nat
    security_group_ids = [
        yandex_vpc_security_group.example.id
    ]
  }
  allow_stopping_for_update = var.storage_vm_allow_stopping_for_update

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.disks.*.id
    content {
        disk_id = secondary_disk.value
    }
}
}