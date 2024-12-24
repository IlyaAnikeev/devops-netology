resource "yandex_vpc_network" "devops" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "devops-subnet-1" {
  name           = var.subnet_1
  zone           = var.zone_1
  network_id     = yandex_vpc_network.devops.id
  v4_cidr_blocks = var.cidr_1
}

resource "yandex_vpc_subnet" "devops-subnet-2" {
  name           = var.subnet_2
  zone           = var.zone_2
  network_id     = yandex_vpc_network.devops.id
  v4_cidr_blocks = var.cidr_2
}

data "template_file" "cloudinit" {
 template = file("${path.module}/cloud-init.yml")
 vars = {
   ssh_public_key = local.ssh-keys
   ssh_private_key = local.ssh-private-keys
 }
}