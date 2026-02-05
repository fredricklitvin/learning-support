resource "google_compute_network" "lab" {
  name                    = "ansible-lab"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "lab" {
  name          = "lab-subnet"
  ip_cidr_range = "10.10.0.0/24"
  region        = var.region
  network       = google_compute_network.lab.id
}

resource "google_compute_firewall" "ssh" {
  name    = "allow-ssh"
  network = google_compute_network.lab.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "http" {
  name    = "allow-http"
  network = google_compute_network.lab.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "https" {
  name    = "allow-http"
  network = google_compute_network.lab.name

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["0.0.0.0/0"]
}

locals {
  common_metadata = {
    ssh-keys = "${var.ssh_user}:${var.ssh_pub_key}"
  }
}

resource "google_compute_instance" "ansible" {
  name         = "ansible-vm"
  machine_type = "e2-micro"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.lab.id
    access_config {}
  }

  metadata = local.common_metadata
}

resource "google_compute_instance" "app" {
  name         = "app-vm"
  machine_type = "e2-micro"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.lab.id
  }

  metadata = local.common_metadata
}

resource "google_compute_instance" "net" {
  name         = "net-vm"
  machine_type = "e2-micro"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.lab.id
  }

  metadata = local.common_metadata
}
