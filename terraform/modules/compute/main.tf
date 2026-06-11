resource "google_compute_instance" "datastream_vm" {
  name         = "datastream-vm"
  machine_type = "e2-standard-2"
  zone         = var.zone

  tags = ["datastream"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    subnetwork = var.subnet_id

    # IMPORTANT: no external IP
  }

  service_account {
    email  = var.service_account_email
    scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  metadata_startup_script = file("${path.module}/startup-script.sh")
}