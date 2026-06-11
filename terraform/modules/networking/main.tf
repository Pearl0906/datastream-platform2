resource "google_compute_network" "vpc" {
  name                    = "datastream-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "datastream-subnet"
  region        = var.region
  network       = google_compute_network.vpc.id
  ip_cidr_range = "10.10.0.0/24"
}
resource "google_compute_router" "router" {
  name    = "datastream-router"
  region  = var.region
  network = google_compute_network.vpc.id
}
resource "google_compute_router_nat" "nat" {
  name                               = "datastream-nat"
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
resource "google_compute_firewall" "iap_ssh" {
  name    = "allow-iap-ssh"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["35.235.240.0/20"] # IAP range
  target_tags   = ["datastream"]
}
resource "google_compute_firewall" "iap_airflow" {
  name    = "allow-iap-airflow"
  network = google_compute_network.vpc.name
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  source_ranges = ["35.235.240.0/20"]

  target_tags = ["datastream"]
}