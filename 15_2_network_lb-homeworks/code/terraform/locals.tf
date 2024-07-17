locals {
    current_timestamp = timestamp()
    formatted_date = formatdate("DD-MM-YYYY", local.current_timestamp)
    bucket_name = "anikeev-${local.formatted_date}"
}

locals {
  metadata = {
    ssh-keys           = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
    serial-port-enable = 1
    user-data          = "#!/bin/bash\n echo \"<html><head><title>Sun</title></head><body><h1>Sun</h1><img src='http://${yandex_storage_bucket.anikeev.bucket_domain_name}/sun.jpg'></body></html>\" > /var/www/html/index.html"
  }
}