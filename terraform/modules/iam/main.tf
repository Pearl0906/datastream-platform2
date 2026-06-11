resource "google_service_account" "datastream_sa" {
  account_id   = "datastream-sa"
  display_name = "DataStream Service Account"
}

resource "google_project_iam_member" "storage_access" {
  project = var.project_id
  role    = "roles/storage.objectAdmin"
  member  = "serviceAccount:${google_service_account.datastream_sa.email}"
}

resource "google_project_iam_member" "bq_access" {
  project = var.project_id
  role    = "roles/bigquery.dataEditor"
  member  = "serviceAccount:${google_service_account.datastream_sa.email}"
}
resource "google_project_service" "cloudbuild" {
  project = var.project_id
  service = "cloudbuild.googleapis.com"
}
resource "google_project_iam_member" "cloudbuild_editor" {
  project = var.project_id
  role    = "roles/cloudbuild.builds.builder"
  member  = "serviceAccount:${data.google_project.project.number}@cloudbuild.gserviceaccount.com"
}
data "google_project" "project" {
  project_id = var.project_id
}