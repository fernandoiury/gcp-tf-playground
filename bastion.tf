resource "google_compute_instance" "bastion" {
  count        = var.bastion__count
  project      = var.project_id
  zone         = data.google_compute_zones.available.names[count.index]
  name         = "${var.project_id}-${var.environment}-bastion-${count.index + 1}"
  machine_type = var.bastion__instance_type

  boot_disk {
    initialize_params {
      image = data.google_compute_image.centos.self_link
    }
  }

  network_interface {
    network    = module.vpc.network_name
    subnetwork = module.vpc.subnets_names[2]
    access_config {
      // add this section to create an external ip     
    }
  }

  tags = ["${var.project_id}-${var.environment}-bastion"]
}
