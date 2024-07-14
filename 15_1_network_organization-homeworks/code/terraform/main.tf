resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_route_table" "private-route" {
  name                 = var.yandex_vpc_route_table[0].route_name
  network_id           = yandex_vpc_network.develop.id
  static_route {
    destination_prefix = var.yandex_vpc_route_table[0].destination_prefix
    next_hop_address   = var.yandex_vpc_route_table[0].next_hop_address
  }
}

resource "yandex_vpc_subnet" "public" {
  name           = var.public_subnet
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.public_cidr
}

resource "yandex_vpc_subnet" "private" {
  name           = var.private_subnet
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.private_cidr
  route_table_id = yandex_vpc_route_table.private-route.id
}