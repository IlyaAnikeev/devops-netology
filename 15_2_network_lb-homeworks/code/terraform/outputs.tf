output "GGroup_VM" {
  value = [
    for instance in yandex_compute_instance_group.group_vm.instances : {
      name = instance.name
      ip_internal = instance.network_interface[0].ip_address
      ip_external = instance.network_interface[0].nat_ip_address}
  ]
}

output "Picture_URL" {
  value = "https://${yandex_storage_bucket.anikeev.bucket_domain_name}/${yandex_storage_object.picture.key}"
  description = "Адрес загруженного в бакет изображения"
}

output "Network_Load_Balancer_Address" {
  value = yandex_lb_network_load_balancer.net_lb.listener.*.external_address_spec[0].*.address
  description = "IP-адрес сетевого балансировщика"
}

output "Application_Load_Balancer_Address" {
  value = yandex_alb_load_balancer.application-balancer.listener.*.endpoint[0].*.address[0].*.external_ipv4_address
  description = "IP-адрес L7-балансировщика"
}