resource "local_file" "hosts_cfg_kubespray" {
  count = var.exclude_ansible ? 0 : 1
  content = templatefile("${path.module}/hosts.tftpl",
    { 
      masters = yandex_compute_instance.master
      workers = yandex_compute_instance.worker
    })

  filename = "../kubespray/inventory/mycluster/hosts.yaml"
}