# Configure the GCP provider
provider "google" {
  project = "eti-project-example"
  region  = "us-central1"
}

# Create a new virtual machine instance
resource "google_compute_instance" "example-instance" {
  name         = "example-instance"
  machine_type = "n1-standard-1"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  tags = ["web-server"]

  metadata_startup_script = "echo 'Hello, world!' > index.html && python -m SimpleHTTPServer 80"
}
