resource "google_storage_bucket" "dataproc_bucket" {
  name     = "${var.project_id}-${var.environment}-dataproc-bucket"
  location = "US"
}

resource "google_dataproc_cluster" "dataproc" {
  name    = var.cluster_name
  project = var.project_id
  region  = var.region_name

#  labels = var.labels

  cluster_config {
    staging_bucket = google_storage_bucket.dataproc_bucket.name

    master_config {
      num_instances = var.master_num_instances
      machine_type  = var.master_machine_type
      disk_config {
        boot_disk_size_gb = var.master_boot_disk_size_gb
        boot_disk_type    = var.worker_boot_disk_type
      }
    }

    worker_config {
      num_instances = var.worker_num_instances
      machine_type  = var.worker_machine_type
      disk_config {
        boot_disk_size_gb = var.worker_boot_disk_size_gb
        boot_disk_type    = var.worker_boot_disk_type
        num_local_ssds    = var.worker_num_local_ssd
      }
    }

    preemptible_worker_config {
      num_instances = var.preemptible_num_instances
    }

    # Override or set some custom properties
    software_config {
      image_version = var.image_version
    }

    gce_cluster_config {
      zone             = var.zone
      subnetwork       = var.subnetwork
      internal_ip_only = true

      tags = compact(concat(var.tags,
        ["${var.project_id}-${var.environment}-dataproc"]
      ))
    }
  }

  depends_on = [google_storage_bucket.dataproc_bucket, google_compute_firewall.dataproc-internal]
}
