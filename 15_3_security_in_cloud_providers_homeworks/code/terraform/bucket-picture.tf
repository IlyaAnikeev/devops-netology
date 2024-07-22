resource "yandex_iam_service_account" "sa" {
  folder_id               = var.folder_id
  name                    = var.sa_name
}

resource "yandex_resourcemanager_folder_iam_member" "editor" {
  folder_id               = var.folder_id
  role                    = var.editor_role
  member                  = "serviceAccount:${yandex_iam_service_account.sa.id}"
  depends_on              = [yandex_iam_service_account.sa]
}

resource "yandex_resourcemanager_folder_iam_member" "encrypter-decrypter" {
  folder_id               = var.folder_id
  role                    = var.encrypter_decrypter_role
  member                  = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

resource "yandex_iam_service_account_static_access_key" "static-key" {
  service_account_id      = yandex_iam_service_account.sa.id
  description             = "static access key for object storage"
}

resource "yandex_kms_symmetric_key" "my_symmetric_key" {
  name                    = var.kms_symmetric_key_name
  default_algorithm       = var.kms_symmetric_key_default_algorithm            # Возможные значения: AES-128, AES-192 и AES-256
  rotation_period         = var.kms_symmetric_key_rotation_period
  description             = "Key for object storage encryption"
#   lifecycle {
#     prevent_destroy     = kms_symmetric_key_lifecycle_prevent_destroy        # Защита ключа от удаления (terraform destroy и т.д.)
# }
}

resource "yandex_storage_bucket" "anikeev" {
  access_key              = yandex_iam_service_account_static_access_key.static-key.access_key
  secret_key              = yandex_iam_service_account_static_access_key.static-key.secret_key
  bucket                  = local.bucket_name
  acl                     = var.anikeev_acl

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.my_symmetric_key.id
        sse_algorithm     = var.encryption_configuration_sse_algorithm
      }
    }
  }
}

resource "yandex_storage_object" "picture" {
  access_key              = yandex_iam_service_account_static_access_key.static-key.access_key
  secret_key              = yandex_iam_service_account_static_access_key.static-key.secret_key
  bucket                  = local.bucket_name
  key                     = var.picture_key
  source                  = var.picture_source
  acl                     = var.picture_acl
  depends_on              = [yandex_storage_bucket.anikeev]
}