##############
# cloud vars #
##############

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

##################
# SSH Public key #
##################

variable "ssh_public_key" {
  type        = map(string)
  default     = {
    serial-port-enable = "1"
    ssh-keys          = "centos:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIODSTu1gaCx5mI8TymZsr91UdjvknDqJFZPd49NaxpJo ilya@anikeev"
  }
  description = "ssh_public_key"
}

###############################
# OS and resources for web_vm #
###############################

variable "web_vm_family" {
  type        = string
  default     = "centos-7"
  description = "centos-7"
}

variable "web_vm_resources" {
  type    = list(object({web_vm_name = string, cpu = number, ram = number, disk = number, core_fraction = number, platform_id = string}))
  default = [
    {
      web_vm_name    = "sonarqube"
      cpu           = 2
      ram           = 4
      disk          = 20
      core_fraction = 5
      platform_id   = "standard-v1"
    },
    {
      web_vm_name    = "nexus"
      cpu           = 2
      ram           = 4
      disk          = 20
      core_fraction = 5
      platform_id   = "standard-v1"
    }
  ] 
}

# boot disk web_vm

variable "web_vm_type" {
  type        = string
  default     = "network-hdd"
  description = "type disk web_vm"
}

# scheduling policy web_vm

variable "web_vm_preemptible" {
  type        = bool
  default     = true
  description = "preemptible web_vm"
}

# network interface web_vm

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
