output "Picture_URL" {
  value = "https://${yandex_storage_bucket.anikeev.bucket_domain_name}/${yandex_storage_object.picture.key}"
  description = "Адрес загруженного в бакет изображения"
}