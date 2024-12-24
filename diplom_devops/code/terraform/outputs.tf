output "cluster_k8s_vm" {
  value = flatten ([
    [
      for master in yandex_compute_instance.master :
      {
        name = master.name
        ip_external = master.network_interface[0].nat_ip_address
        ip_internal = master.network_interface[0].ip_address
      }
    ],
    [
      for worker in yandex_compute_instance.worker : 
      {
        name = worker.name
        ip_external = worker.network_interface[0].nat_ip_address
        ip_internal = worker.network_interface[0].ip_address
      }
    ]
  ])
}

output "Grafana_Network_Load_Balancer_Address" {
  value = yandex_lb_network_load_balancer.nlb-grafana.listener.*.external_address_spec[0].*.address
  description = "Адрес сетевого балансировщика для Grafana"
}

output "Web_App_Network_Load_Balancer_Address" {
  value = yandex_lb_network_load_balancer.nlb-web-app.listener.*.external_address_spec[0].*.address
  description = "Адрес сетевого балансировщика Web App"
}