#first VM variables

variable "vm_web_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "OS version"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "platform id"
}

variable "vm_web_preemptible" {
  type        = bool
  default     = true
  description = "preemptible VM"
}

variable "vm_web_nat" {
  type        = bool
  default     = true
  description = "network interface"
}

#second VM variables

variable "vm_db_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "OS version"
}

variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "platform id"
}

variable "vm_db_preemptible" {
  type        = bool
  default     = true
  description = "preemptible VM"
}

variable "vm_db_nat" {
  type        = bool
  default     = true
  description = "network interface"
}

#common variables

variable "vms_resources" {
  type        = map(map(number))
  default     = {
    vm_web_resources = {
      cores         = 2
      memory        = 1
      core_fraction = 5
    }
    vm_db_resources = {
      cores         = 2
      memory        = 2
      core_fraction = 20
    }
  }
  description = "resources for 2 VM"
}

variable "vms_ssh_root_key" {
  type        = map(string)
  default     = {
    serial-port-enable = "1"
    ssh-keys          = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINrIvg5J3nMRnaXxY7WrJz1QuUpiDP3AqqLLZd7csLhn ilya@anikeev"
  }
  description = "metadata for 2 VM"
}