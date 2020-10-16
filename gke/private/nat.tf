resource "google_compute_router" "platform_router" {
  name    = "platform-${var.region}-router"
  region  = "${var.region}"
  network = "${google_compute_network.platform_vpc.id}"
}

resource "google_compute_router_nat" "platform_nat" {
  name                               = "plaform-${var.region}-nat"
  router                             = "${google_compute_router.platform_router.name}"
  region                             = "${google_compute_router.platform_router.region}"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}