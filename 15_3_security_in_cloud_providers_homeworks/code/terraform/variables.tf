##############
# cloud vars #
##############

variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "public_subnet" {
  type        = string
  default     = "public-subnet"
  description = "subnet name"
}

##################
# bucket-picture #
##################

variable "sa_name" {
  type        = string
  default     = "bucket-sa"
}

variable "editor_role" {
  type        = string
  default     = "storage.editor"
}

variable "encrypter_decrypter_role" {
  type        = string
  default     = "kms.keys.encrypterDecrypter"
}

variable "kms_symmetric_key_name" {
  type        = string
  default     = "my_symmetric_key"
}

variable "kms_symmetric_key_default_algorithm" {
  type        = string
  default     = "AES_128"
}

variable "kms_symmetric_key_rotation_period" {
  type        = string
  default     = "72h"
}

variable "kms_symmetric_key_lifecycle_prevent_destroy" {
  type        = bool
  default     = true
}

variable "anikeev_acl" {
  type        = string
  default     = "public-read"
}

variable "encryption_configuration_sse_algorithm" {
  type        = string
  default     = "aws:kms"
}

variable "picture_key" {
  type        = string
  default     = "sun.jpg"
}

variable "picture_source" {
  type        = string
  default     = "~/dz/sun.jpg"
}

variable "picture_acl" {
  type        = string
  default     = "public-read"
}