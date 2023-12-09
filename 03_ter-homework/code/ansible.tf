resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/hosts.tftpl",
    { 
      webservers = yandex_compute_instance.web_vm,
      databases  = yandex_compute_instance.db_vm,
      storage    = [yandex_compute_instance.storage]
    })

  filename = "${abspath(path.module)}/hosts.cfg"
}

resource "null_resource" "web_hosts_provision" {

  depends_on = [yandex_compute_instance.storage]

  provisioner "local-exec" {
    command = var.web_hosts_provis
  }

  provisioner "local-exec" {
    command  = "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ${abspath(path.module)}/hosts.cfg ${abspath(path.module)}/test.yml"
    on_failure = continue
    environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
  }
    triggers = {
      always_run         = "${timestamp()}"
      playbook_src_hash  = file("${abspath(path.module)}/test.yml")
      ssh_public_key     = var.public_key
    }
  }