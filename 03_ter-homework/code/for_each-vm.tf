#Create 2 VM (main & replica)

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
      image_id      = data.yandex_compute_image.ubuntu-2004-lts.image_id
      type          = "network-hdd"
      size          = each.value.disk
    }   
  }

  metadata          = {
    serial-port-enable = "1"
    ssh-keys        = local.ssh-keys
  }

  scheduling_policy { 
    preemptible     = true 
  }

  network_interface { 
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = false
    security_group_ids = [
        yandex_vpc_security_group.example.id
    ]
  }
  allow_stopping_for_update = true
} 

variable "db_vm_resources" {
  type    = list(object({db_vm_name = string, cpu = number, ram = number, disk = number, core_fraction = number, platform_id = string}))
  default = [
    {
      db_vm_name    = "main"
      cpu           = 2
      ram           = 2
      disk          = 15
      core_fraction = 5
      platform_id   = "standard-v1"
    },
    {
      db_vm_name    = "replica"
      cpu           = 4
      ram           = 4
      disk          = 20
      core_fraction = 20
      platform_id   = "standard-v1"
    }
  ] 
}