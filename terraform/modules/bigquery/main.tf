resource "google_bigquery_dataset" "analytics" {
  dataset_id  = "production_analytics"
  location    = "US"
  description = "Main analytics dataset for DataStream project"
}