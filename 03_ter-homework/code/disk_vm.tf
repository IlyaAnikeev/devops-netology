#Create 3 Disks and 1 VM (storage)

resource "yandex_compute_disk" "disks" {
  name       = "disk-${count.index+1}"
  type       = "network-hdd"
  zone       = "ru-central1-a"
  size       = 1
  count      = 3
}

resource "yandex_compute_instance" "storage" {
  name     = "storage"
  hostname = "storage"
  zone     = "ru-central1-a"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 5
  }


  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
      type     = "network-hdd"
      size     = 5
    }   
  }

  metadata          = {
    serial-port-enable = "1"
    ssh-keys        = local.ssh-keys
  }

  scheduling_policy { 
    preemptible = true 
  }

  network_interface { 
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = false
    security_group_ids = [
        yandex_vpc_security_group.example.id
    ]
  }
  allow_stopping_for_update = true

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.disks.*.id
    content {
        disk_id = secondary_disk.value
    }
}
}

