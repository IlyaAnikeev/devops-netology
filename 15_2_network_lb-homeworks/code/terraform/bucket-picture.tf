resource "yandex_iam_service_account" "sa" {
  folder_id          = var.folder_id
  name               = var.sa_name
}

resource "yandex_resourcemanager_folder_iam_member" "editor" {
  folder_id          = var.folder_id
  role               = var.editor_role
  member             = "serviceAccount:${yandex_iam_service_account.sa.id}"
  depends_on         = [yandex_iam_service_account.sa]
}

resource "yandex_iam_service_account_static_access_key" "static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}

resource "yandex_storage_bucket" "anikeev" {
  access_key         = yandex_iam_service_account_static_access_key.static-key.access_key
  secret_key         = yandex_iam_service_account_static_access_key.static-key.secret_key
  bucket             = local.bucket_name
  acl                = var.anikeev_acl
}

resource "yandex_storage_object" "picture" {
  access_key         = yandex_iam_service_account_static_access_key.static-key.access_key
  secret_key         = yandex_iam_service_account_static_access_key.static-key.secret_key
  bucket             = local.bucket_name
  key                = var.picture_key
  source             = var.picture_source
  acl                = var.picture_acl
  depends_on         = [yandex_storage_bucket.anikeev]
}