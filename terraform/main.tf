module "networking" {
  source     = "./modules/networking"
  project_id = var.project_id
  region     = var.region
}

module "storage" {
  source     = "./modules/storage"
  project_id = var.project_id
  region     = var.region
}

module "bigquery" {
  source     = "./modules/bigquery"
  project_id = var.project_id
}
module "iam" {
  source     = "./modules/iam"
  project_id = var.project_id
}
module "compute" {
  source = "./modules/compute"

  project_id            = var.project_id
  region                = var.region
  zone                  = var.zone
  subnet_id             = module.networking.subnet_name
  service_account_email = module.iam.service_account_email
}
module "monitoring" {
  source      = "./modules/monitoring"
  project_id  = var.project_id
}