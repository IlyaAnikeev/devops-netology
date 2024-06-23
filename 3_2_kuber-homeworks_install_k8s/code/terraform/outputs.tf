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
