resource "google_compute_firewall" "dataproc-internal" {
  name    = "${var.project_id}-${var.environment}-dataproc-internal"
  network = var.network

  allow {
    protocol = "all"
  }
  source_tags = ["${var.project_id}-${var.environment}-dataproc"]
  target_tags = ["${var.project_id}-${var.environment}-dataproc"]
}
