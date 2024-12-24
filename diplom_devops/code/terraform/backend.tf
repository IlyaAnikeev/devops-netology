terraform {
  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket = "for-state-tf"
    region = "ru-central1"
    key = "for-state-tf/terraform.tfstate"
    skip_region_validation = true
    skip_credentials_validation = true
  }
}