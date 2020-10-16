# vpc network

resource "google_compute_network" "platform_vpc" {
  name                    = "platform-${var.region}-vpc"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "platform_vpc_subnet" {
  name          = "platform-${var.region}-vpc-subnet"
  ip_cidr_range = "10.0.0.0/16"
  network       = "${google_compute_network.platform_vpc.id}"
  region        = "${var.region}"

  secondary_ip_range {
    range_name    = "platform-pod-ip-range"
    ip_cidr_range = "10.10.0.0/24"
  }

  secondary_ip_range {
    range_name    = "platform-svc-ip-range"
    ip_cidr_range = "10.11.0.0/24"
  }

  depends_on = ["google_compute_network.platform_vpc"]
}

resource "google_compute_firewall" "platform_vpc_firewall" {
  name    = "platform-${var.region}-vpc-firewall"
  network = "${google_compute_network.platform_vpc.id}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "22"]
  }
}