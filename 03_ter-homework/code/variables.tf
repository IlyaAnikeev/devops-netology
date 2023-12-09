###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

################
# SSH Public key
################

variable "ssh_public_key" {
  type        = map(string)
  default     = {
    serial-port-enable = "1"
    ssh-keys          = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMlhxLn/G5dV7uZHunOOcuR7Ptvp9SFHSqjsXN4r5VXh ilya@anikeev"
  }
  description = "ssh_public_key"
}

variable "public_key" {
  type        = string
  default     = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMlhxLn/G5dV7uZHunOOcuR7Ptvp9SFHSqjsXN4r5VXh ilya@anikeev"
  description = "public_key"
}

#############################
# OS and resources for web_vm
#############################

variable "web_vm_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "ubuntu-2004-lts"
}

variable "web_vm_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "platform id web_vm"
}

variable "web_vm_count" {
  type        = number
  default     = 2
  description = "number of web_vm"
}

variable "web_vm_cores" {
  type        = number
  default     = 2
  description = "cores web_vm"
}

variable "web_vm_memory" {
  type        = number
  default     = 1
  description = "memory web_vm"
}

variable "web_vm_core_fraction" {
  type        = number
  default     = 5
  description = "core_fraction web_vm"
}

# boot_disk_web_vm

variable "web_vm_type" {
  type        = string
  default     = "network-hdd"
  description = "type disk web_vm"
}

variable "web_vm_size" {
  type        = number
  default     = 5
  description = "size disk web_vm"
}

# scheduling policy web_vm

variable "web_vm_preemptible" {
  type        = bool
  default     = true
  description = "preemptible web_vm"
}

# network_interface

variable "web_vm_nat" {
  type        = bool
  default     = true
  description = "nat web_vm"
}

variable "web_vm_allow_stopping_for_update" {
  type        = bool
  default     = true
  description = "allow_stopping_for_update web_vm"
}


############################
# OS and resources for db_vm
############################

variable "db_vm_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "ubuntu-2004-lts"
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

# boot_disk_db_vm

variable "db_vm_type" {
  type        = string
  default     = "network-hdd"
  description = "type disk db_vm"
}

# scheduling policy db_vm

variable "db_vm_preemptible" {
  type        = bool
  default     = true
  description = "preemptible db_vm"
}

# network_interface db_vm

variable "db_vm_nat" {
  type        = bool
  default     = true
  description = "nat db_vm"
}

variable "db_vm_allow_stopping_for_update" {
  type        = bool
  default     = true
  description = "allow_stopping_for_update db_vm"
}


#################################
# OS and resources for storage_vm
#################################

variable "storage_vm_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "ubuntu-2004-lts"
}

variable "storage_vm_name" {
  type        = string
  default     = "storage"
  description = "name storage_vm"
}

variable "storage_vm_hostname" {
  type        = string
  default     = "storage"
  description = "hostname storage_vm"
}

variable "storage_vm_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "zone storage_vm"
}

variable "storage_vm_cores" {
  type        = number
  default     = 2
  description = "cores storage_vm"
}

variable "storage_vm_memory" {
  type        = number
  default     = 2
  description = "memory storage_vm"
}

variable "storage_vm_core_fraction" {
  type        = number
  default     = 5
  description = "core_fraction storage_vm"
}

# boot_disk_storage_vm

variable "storage_vm_type" {
  type        = string
  default     = "network-hdd"
  description = "type disk storage_vm"
}

# scheduling policy storage_vm

variable "storage_vm_preemptible" {
  type        = bool
  default     = true
  description = "preemptible storage_vm"
}

variable "storage_vm_size" {
  type        = number
  default     = 5
  description = "size disk storage_vm"
}

# network_interface storage_vm

variable "storage_vm_nat" {
  type        = bool
  default     = true
  description = "nat storage_vm"
}

variable "storage_vm_allow_stopping_for_update" {
  type        = bool
  default     = true
  description = "allow_stopping_for_update storage_vm"
}


##############################
# resource for disks (storage)
##############################

variable "disk_vm_type" {
  type        = string
  default     = "network-hdd"
  description = "type disk"
}

variable "disk_vm_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "zone disk"
}

variable "disk_vm_size" {
  type        = number
  default     = 1
  description = "size disk"
}

variable "disk_vm_count" {
  type        = number
  default     = 3
  description = "number"
}


#############
# ansible.tf
#############

variable "web_hosts_provis" {
  type        = string
  default     = "sleep 100"
  description = "provisioner local-exec"
}