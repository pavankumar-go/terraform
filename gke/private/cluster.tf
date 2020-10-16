provider "google" {
  credentials = file("/Users/pavan/.config/gcloud/admin-atreus.json")
  project     = "${var.project_id}"
  region      = "${var.region}"
}


resource "google_container_cluster" "platform" {
  # provider                 = google-beta
  name                     = "platform-${var.region}-cluster"
  location                 = "${var.region}"
  network                  = "${google_compute_network.platform_vpc.id}"
  subnetwork               = "${google_compute_subnetwork.platform_vpc_subnet.id}"
  min_master_version       = "1.16.13-gke.401"
  remove_default_node_pool = true
  initial_node_count       = 1

  master_auth {
    client_certificate_config {
      issue_client_certificate = "false"
    }
  }

  private_cluster_config {
    enable_private_endpoint = "false"
    enable_private_nodes    = "true"
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "14.98.153.6/32"
      display_name = "DAC VPN"
    }
  }

  network_policy {
    enabled = "true"
    # Tigera (Calico Felix) is the only provider
    provider = "CALICO"
  }

  addons_config {
    http_load_balancing {
      disabled = "true"
    }
  }

  cluster_autoscaling {
    enabled = "false"
  }

  ip_allocation_policy {
    cluster_ipv4_cidr_block       = "10.13.0.0/16"
    services_ipv4_cidr_block      = "10.14.0.0/16"
  }
}