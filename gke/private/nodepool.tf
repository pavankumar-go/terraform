resource "google_container_node_pool" "platform_apps" {
  name       = "platform-apps"
  location   = "${var.region}"
  cluster    = "${google_container_cluster.platform.name}"
  node_count = 1

  management {
    auto_repair  = "false"
    auto_upgrade = "false"
  }

  upgrade_settings {
    max_surge       = 1
    max_unavailable = 0
  }

  node_config {
    preemptible  = "false"
    image_type   = "COS"
    machine_type = "n1-standard-4"

    labels = {
      workload = "apps"
    }

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/monitoring.write",
      "https://www.googleapis.com/auth/pubsub",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/trace.append"
    ]
  }
}