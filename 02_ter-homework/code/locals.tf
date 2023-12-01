locals {
  env_1 = "web"
  env_2  = "db"  
  project = "netology-develop-platform"
  vm_web_name = "${local.project}-${local.env_1}"
  vm_db_name = "${local.project}-${local.env_2}"
}