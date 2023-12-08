output "VM" {
  value = flatten ([
    [
      for vm_web in yandex_compute_instance.web_vm:
      {
        name = vm_web.name
        id   = vm_web.id
        fqdn = vm_web.fqdn
      }
    ],
    [
      for db_vm in yandex_compute_instance.db_vm: 
      {
        name = db_vm.name
        id   = db_vm.id
        fqdn = db_vm.fqdn
      }
    ],
    [
      for storage in [yandex_compute_instance.storage]:
      {
        name = storage.name
        id   = storage.id
        fqdn = storage.fqdn
      }
    ]
  ])
}
