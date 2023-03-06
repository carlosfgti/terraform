# Configure the GCP provider
provider "google" {
  project = "eti-project-example"
  region  = "us-central1"
}

# Create three GCE instances
resource "google_compute_instance" "example_instances" {
  count         = 3
  name          = "example-instance-${count.index + 1}"
  machine_type  = "n1-standard-1"
  boot_disk {
    initialize_params {
      image = "ami-9173717231723213"
    }
  }
  network_interface {
    network = "default"
  }
}
