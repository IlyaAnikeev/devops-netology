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

variable "public_subnet" {
  type        = string
  default     = "public-subnet"
  description = "subnet name"
}

##################
# Public SSH key #
##################

variable "ssh_authorized_keys" {
  type    = list(string)
  default = ["~/.ssh/id_ed25519.pub"]
}

##################
# bucket-picture #
##################

variable "sa_name" {
  type        = string
  default     = "bucket-sa"
}

variable "editor_role" {
  type        = string
  default     = "storage.editor"
}

variable "anikeev_acl" {
  type        = string
  default     = "public-read"
}

variable "picture_key" {
  type        = string
  default     = "sun.jpg"
}

variable "picture_source" {
  type        = string
  default     = "~/dz/sun.jpg"
}

variable "picture_acl" {
  type        = string
  default     = "public-read"
}

#################################
# OS and resources for group_vm #
#################################

variable "groupvm_sa_name" {
  type        = string
  default     = "groupvm-sa"
}

variable "groupvm_editor_role" {
  type        = string
  default     = "editor"
}

variable "group_vm_resources" {
  type    = list(object({name = string, cores = number, memory = number, core_fraction = number, platform_id = string}))
  default = [
    {
      name     = "lamp-group"
      cores           = 2
      memory          = 2
      core_fraction   = 5
      platform_id     = "standard-v1"
    }
  ] 
}

#---------------------------
# deletion protection group_vm
#---------------------------

variable "group_vm_deletion_protection" {
  type        = bool
  default     = false
}

#-------------------
# boot disk group_vm
#-------------------

variable "group_vm_boot_disk" {
  type    = list(object({size = number, type = string, image_id = string}))
  default = [
    {
      size     = 10
      type     = "network-hdd"
      image_id = "fd827b91d99psvq5fjit"
    }
  ] 
}

#---------------------------
# scheduling policy group_vm
#---------------------------

variable "group_vm_preemptible" {
  type        = bool
  default     = true
  description = "preemptible"
}

#---------------------------
# network interface group_vm
#---------------------------

variable "group_vm_nat" {
  type        = bool
  default     = true
  description = "nat"
}

#-------------
# scale policy
#-------------

variable "scale_policy_fixed_scale_size" {
  type        = number
  default     = 3
}

#--------------
# deploy policy
#--------------

variable "deploy_policy_max_unavailable" {
  type        = number
  default     = 1
}

variable "deploy_policy_max_expansion" {
  type        = number
  default     = 0
}

#-------------
# health check
#-------------

variable "health_check_interval" {
  type        = number
  default     = 20
}

variable "health_check_timeout" {
  type        = number
  default     = 10
}

variable "health_check_unhealthy_threshold" {
  type        = number
  default     = 3
}

variable "health_check_tcp_options_port" {
  type        = number
  default     = 80
}

#################
# load balancer #
#################

variable "load_balancer_target_group_name" {
  type        = string
  default     = "lamp-group"
}

variable "net_lb_name" {
  type        = string
  default     = "lamp-lb"
}

variable "net_lb_deletion_protection" {
  type        = bool
  default     = false
}

variable "net_lb_listener_name" {
  type        = string
  default     = "http-check"
}

variable "net_lb_listener_port" {
  type        = number
  default     = 80
}

variable "net_lb_listener_ip_version" {
  type        = string
  default     = "ipv4"
}

variable "net_lb_healthcheck_name" {
  type        = string
  default     = "http"
}

variable "net_lb_healthcheck_interval" {
  type        = number
  default     = 10
}

variable "net_lb_healthcheck_timeout" {
  type        = number
  default     = 5
}

variable "net_lb_healthcheck_unhealthy_threshold" {
  type        = number
  default     = 3
}

variable "net_lb_healthcheck_healthy_threshold" {
  type        = number
  default     = 5
}

variable "net_lb_healthcheck_port" {
  type        = number
  default     = 80
}

variable "net_lb_healthcheck_path" {
  type        = string
  default     = "/"
}

#############################
# Application Load Balancer #
#############################

#-------
# alb_tg
#-------

variable "alb_tg_name" {
  type        = string
  default     = "group-vm"
}

#------------
# alb_backend
#------------

variable "alb_backend_name" {
  type        = string
  default     = "backend-balancer"
}

variable "alb_backend_source_ip" {
  type        = bool
  default     = true
}

variable "alb_http_backend_name" {
  type        = string
  default     = "http-backend"
}

variable "alb_http_backend_weight" {
  type        = number
  default     = 1
}

variable "alb_http_backend_port" {
  type        = number
  default     = 80
}

variable "alb_http_backend_panic_threshold" {
  type        = number
  default     = 90
}

variable "alb_http_backend_healthcheck_timeout" {
  type        = string
  default     = "10s"
}

variable "alb_http_backend_healthcheck_interval" {
  type        = string
  default     = "2s"
}

variable "alb_http_backend_healthcheck_healthy_threshold" {
  type        = number
  default     = 10
}

variable "alb_http_backend_healthcheck_unhealthy_threshold" {
  type        = number
  default     = 15
}

variable "alb_http_backend_healthcheck_path" {
  type        = string
  default     = "/"
}

#----------------
# alb http router
#----------------

variable "alb_http_router_name" {
  type        = string
  default     = "http-router"
}

variable "alb_http_router_tf_lable" {
  type        = string
  default     = "tf-label-value"
}

variable "alb_http_router_empty-label" {
  type        = string
  default     = ""
}

#-----------------
# alb virtual host
#-----------------

variable "alb_virtual_host_name" {
  type        = string
  default     = "virtual-host"
}

variable "alb_virtual_host_route_name" {
  type        = string
  default     = "route-http"
}

variable "alb_virtual_host_route_timeout" {
  type        = string
  default     = "60s"
}

#-------
# alb l7
#-------

variable "alb_load_balancer_name" {
  type        = string
  default     = "app-balancer"
}

variable "alb_load_balancer_listener_name" {
  type        = string
  default     = "listener"
}