resource "local_file" "hosts_cfg_kubespray" {
  content = templatefile("${path.module}/hosts.tftpl",
    { 
      masters = yandex_compute_instance.master
      workers = yandex_compute_instance.worker
    })

  filename = "../kubespray/inventory/mycluster/hosts.yaml"
}

resource "local_file" "hosts_cfg_ha" {
  content = templatefile("${path.module}/ha.tftpl",
    { 
      masters = yandex_compute_instance.master
      workers = yandex_compute_instance.worker
    })

  filename = "../HA/hosts.yaml"
}  