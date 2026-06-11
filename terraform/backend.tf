terraform {
  backend "gcs" {
    bucket = "costops-monitor-tf-state"
    prefix = "terraform/state"
  }
}