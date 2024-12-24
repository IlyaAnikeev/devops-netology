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

variable "zone_1" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "cidr_1" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "zone_2" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "cidr_2" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "subnet_1" {
  type        = string
  default     = "devops-subnet-1"
  description = "subnet name"
}

variable "subnet_2" {
  type        = string
  default     = "devops-subnet-2"
  description = "subnet name"
}

variable "vpc_name" {
  type        = string
  default     = "devops"
  description = "VPC network&subnet name"
}

###############################
# OS and resources for master #
###############################

variable "os_master" {
  type        = string
  default     = "ubuntu-2404-lts-oslogin"
  description = "ubuntu-2404-lts-oslogin"
}

variable "master_resources" {
  type    = list(object({master_name = string, master_hostname = string, count_vm = number, cpu = number, ram = number, disk_size = number, core_fraction = number, platform_id = string}))
  default = [
    {
      master_name     = "master"
      master_hostname = "master"
      count_vm        = 1
      cpu             = 2
      ram             = 4
      disk_size       = 20
      core_fraction   = 20
      platform_id     = "standard-v1"
    }
  ] 
}

#-----------------
# boot disk master
#-----------------

variable "master_type" {
  type        = string
  default     = "network-hdd"
  description = "type disk"
}

#--------------------------
# serial port enable master
#--------------------------

variable "serial_port_master" {
  type        = string
  default     = "1"
  description = "serial port enable"
}

#-------------------------
# scheduling policy master
#-------------------------

variable "master_preemptible" {
  type        = bool
  default     = true
  description = "preemptible"
}

#-------------------------
# network interface master
#-------------------------

variable "master_nat" {
  type        = bool
  default     = true
  description = "nat"
}

#---------------------------------
# allow stopping for update master
#---------------------------------

variable "master_allow_stopping_for_update" {
  type        = bool
  default     = true
  description = "allow stopping for update"
}

###############################
# OS and resources for worker #
###############################

variable "os_worker" {
  type        = string
  default     = "ubuntu-2404-lts-oslogin"
  description = "ubuntu-2404-lts-oslogin"
}

variable "worker_resources" {
  type    = list(object({worker_name = string, worker_hostname = string, count_vm = number, cpu = number, ram = number, disk_size = number, core_fraction = number, platform_id = string}))
  default = [
    {
      worker_name     = "worker"
      worker_hostname = "worker"
      count_vm        = 2
      cpu             = 2
      ram             = 4
      disk_size       = 20
      core_fraction   = 20
      platform_id     = "standard-v1"
    }
  ] 
}

#-----------------
# boot disk worker
#-----------------

variable "worker_type" {
  type        = string
  default     = "network-hdd"
  description = "type disk"
}

#--------------------------
# serial port enable worker
#--------------------------

variable "serial_port_worker" {
  type        = string
  default     = "1"
  description = "serial port enable"
}

#-------------------------
# scheduling policy worker
#-------------------------

variable "worker_preemptible" {
  type        = bool
  default     = true
  description = "preemptible"
}

#-------------------------
# network interface worker
#-------------------------

variable "worker_nat" {
  type        = bool
  default     = true
  description = "nat"
}

#---------------------------------
# allow stopping for update worker
#---------------------------------

variable "worker_allow_stopping_for_update" {
  type        = bool
  default     = true
  description = "allow stopping for update"
}

######################
# Exclude ansible.tf #
######################

variable "exclude_ansible" {
  type        = bool
  default     = false
}