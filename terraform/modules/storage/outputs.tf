output "raw_bucket" {
  value = google_storage_bucket.raw_data.name
}

output "logs_bucket" {
  value = google_storage_bucket.logs.name
}