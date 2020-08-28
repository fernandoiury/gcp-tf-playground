# GKE
module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google//modules/beta-private-cluster"
  project_id                 = var.project_id
  name                       = "${var.project_id}-${var.environment}-gke"
  kubernetes_version         = var.gks__version
  region                     = var.region
  zones                      = data.google_compute_zones.available.names
  network                    = module.vpc.network_name
  subnetwork                 = "subnet-gke"
  ip_range_pods              = "subnet-gke-pods"
  ip_range_services          = "subnet-gke-services"
  http_load_balancing        = true
  horizontal_pod_autoscaling = true
  network_policy             = true
  #  enable_private_endpoint    = true # if enabled we can only access through VPN or google ips
  enable_private_nodes     = true
  create_service_account   = true
  master_ipv4_cidr_block   = var.gks__master_cidr_block # it needs to be a /28
  remove_default_node_pool = true
  logging_service          = var.gks__logging_service
  monitoring_service       = var.gks__monitoring_service

  master_authorized_networks = [
    {
      cidr_block   = "0.0.0.0/0"
      display_name = "ALL-FOR-NOW"
    }
  ]

  node_pools = [
    {
      name               = "non-preemptible-node-pool"
      machine_type       = "n1-standard-4"
      min_count          = 1
      max_count          = 10
      local_ssd_count    = 0
      disk_size_gb       = 100
      disk_type          = "pd-ssd"
      image_type         = "COS"
      auto_repair        = true
      auto_upgrade       = true
      preemptible        = false
      initial_node_count = 1 # this is per ZONE, so lets start with one non-preemptible per zone
    },
    {
      name            = "preemptible-node-pool"
      machine_type    = "n1-standard-4"
      min_count       = 0
      max_count       = 10
      local_ssd_count = 0
      disk_size_gb    = 100
      disk_type       = "pd-ssd"
      image_type      = "COS"
      auto_repair     = true
      auto_upgrade    = true
      preemptible     = true
      #      initial_node_count = 2 # preemptible nodes will run only when necessary
    },
  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]

    non-preemptible-node-pool = []
    preemptible-node-pool     = []
  }

  node_pools_labels = {
    all = {}

    non-preemptible-node-pool = {
      non-preemptible-node-pool = true
    }

    preemptible-node-pool = {
      preemptible-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    non-preemptible-node-pool = {
      node-pool-metadata-custom-value = "${var.project_id}-${var.environment}-non-preemptible-node-pool"
    }

    preemptible-node-pool = {
      node-pool-metadata-custom-value = "${var.project_id}-${var.environment}-preemptible-node-pool"
    }
  }

  node_pools_taints = {
    all = [
      {
        key    = "default-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]

    non-preemptible-node-pool = []
    preemptible-node-pool     = []
  }

  node_pools_tags = {
    all = [
      "${var.project_id}-${var.environment}-gke-workers"
    ]

    non-preemptible-node-pool = [
      "non-preemptible-node-pool",
    ]

    preemptible-node-pool = [
      "preemptible-node-pool",
    ]
  }
}
