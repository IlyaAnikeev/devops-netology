output "VM" {
  value = flatten ([
    [
      for web_vm in yandex_compute_instance.web_vm: 
      {
        name        = web_vm.name
        id          = web_vm.id
        fqdn        = web_vm.fqdn
        ip_external = web_vm.network_interface[0].nat_ip_address
        ip_internal = web_vm.network_interface[0].ip_address
      }
    ]
  ])
}
