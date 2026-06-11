output "network_name" {
  value = module.networking.network_name
}

output "subnet_name" {
  value = module.networking.subnet_name
}

output "raw_bucket" {
  value = module.storage.raw_bucket
}

output "logs_bucket" {
  value = module.storage.logs_bucket
}

output "bigquery_dataset" {
  value = module.bigquery.dataset_id
}
output "service_account_email" {
  value = module.iam.service_account_email
}