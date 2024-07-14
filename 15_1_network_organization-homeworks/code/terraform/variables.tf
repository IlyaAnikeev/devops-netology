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
variable "public_cidr" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "private_cidr" {
  type        = list(string)
  default     = ["192.168.20.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "public_subnet" {
  type        = string
  default     = "public"
  description = "public subnet name"
}

variable "private_subnet" {
  type        = string
  default     = "private"
  description = "private subnet name"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network"
}

##################
# SSH Public key #
##################

variable "ssh_public_key" {
  type        = map(string)
  default     = {
    serial-port-enable = "1"
    ssh-keys          = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICr+sqKu/JAA9HeBbtKaVHNOvAw8prJlDeybe/gGdPgF ilya@anikeev"
  }
  description = "ssh_public_key"
}

###############################
# OS and resources for public #
###############################

variable "public_os" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "ubuntu-2004-lts"
}

variable "public_resources" {
  type    = list(object({public_name = string, public_hostname = string, cores = number, memory = number, core_fraction = number, platform_id = string}))
  default = [
    {
      public_name     = "public"
      public_hostname = "public"
      cores           = 2
      memory          = 2
      core_fraction   = 5
      platform_id     = "standard-v1"
    }
  ] 
}

#-----------------
# boot disk public
#-----------------

variable "public_boot_disk" {
  type    = list(object({size = number, type = string, image_id = string}))
  default = [
    {
      size     = 10
      type     = "network-hdd"
      image_id = "fd8pbf0hl06ks8s3scqk"
    }
  ] 
}

#-------------------------
# scheduling policy public
#-------------------------

variable "public_preemptible" {
  type        = bool
  default     = true
  description = "preemptible"
}

#-------------------------
# network interface public
#-------------------------

variable "public_nat" {
  type        = bool
  default     = true
  description = "nat"
}

#---------------------------------
# allow stopping for update public
#---------------------------------

variable "public_allow_stopping_for_update" {
  type        = bool
  default     = true
  description = "allow stopping for update"
}

################################
# OS and resources for private #
################################

variable "private_os" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "ubuntu-2004-lts"
}

variable "private_resources" {
  type    = list(object({private_name = string, private_hostname = string, cores = number, memory = number, core_fraction = number, platform_id = string}))
  default = [
    {
      private_name     = "private"
      private_hostname = "private"
      cores           = 2
      memory          = 2
      core_fraction   = 5
      platform_id     = "standard-v1"
    }
  ] 
}

#------------------
# boot disk private
#------------------

variable "private_boot_disk" {
  type    = list(object({size = number, type = string, image_id = string}))
  default = [
    {
      size     = 10
      type     = "network-hdd"
      image_id = "fd8pbf0hl06ks8s3scqk"
    }
  ] 
}

#--------------------------
# scheduling policy private
#--------------------------

variable "private_preemptible" {
  type        = bool
  default     = true
  description = "preemptible"
}

#--------------------------
# network interface private
#--------------------------

variable "private_nat" {
  type        = bool
  default     = false
  description = "nat"
}

#----------------------------------
# allow stopping for update private
#----------------------------------

variable "private_allow_stopping_for_update" {
  type        = bool
  default     = true
  description = "allow stopping for update"
}

############################
# OS and resources for nat #
############################

variable "nat_os" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "ubuntu-2004-lts"
}

variable "nat_resources" {
  type    = list(object({nat_name = string, nat_hostname = string, cores = number, memory = number, core_fraction = number, platform_id = string}))
  default = [
    {
      nat_name     = "nat"
      nat_hostname = "nat"
      cores           = 2
      memory          = 2
      core_fraction   = 5
      platform_id     = "standard-v1"
    }
  ] 
}

#--------------
# boot disk nat
#--------------

variable "nat_boot_disk" {
  type    = list(object({size = number, type = string, image_id = string}))
  default = [
    {
      size     = 10
      type     = "network-hdd"
      image_id = "fd80mrhj8fl2oe87o4e1"
    }
  ] 
}

#----------------------
# scheduling policy nat
#----------------------

variable "nat_preemptible" {
  type        = bool
  default     = true
  description = "preemptible"
}

#----------------------
# network interface nat
#----------------------

variable "nat_instance_nat" {
  type        = bool
  default     = true
  description = "nat"
}

variable "nat_instance_ip_address" {
  type        = string
  default     = "192.168.10.254"
  description = "ip address"
}

#------------------------------
# allow stopping for update nat
#------------------------------

variable "nat_allow_stopping_for_update" {
  type        = bool
  default     = true
  description = "allow stopping for update"
}

##########################
# yandex_vpc_route_table #
##########################

variable "yandex_vpc_route_table" {
  type    = list(object({route_name = string, destination_prefix = string,  next_hop_address = string}))
  default = [
    {
      route_name         = "private-route"
      destination_prefix = "0.0.0.0/0"
      next_hop_address   = "192.168.10.254"
    }
  ] 
}