resource "google_storage_bucket" "raw_data" {
  name                        = "${var.project_id}-raw-data"
  location                    = var.region
  force_destroy               = true
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "logs" {
  name                        = "${var.project_id}-logs"
  location                    = var.region
  force_destroy               = true
  uniform_bucket_level_access = true
}