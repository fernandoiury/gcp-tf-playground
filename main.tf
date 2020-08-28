# Basic VPC 
module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "2.0.1"

  project_id   = var.project_id
  network_name = "${var.project_id}-${var.environment}-vpc"
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name           = "subnet-gke"
      subnet_ip             = var.vpc__subnet_gke_cidr
      subnet_region         = var.region
      subnet_private_access = "true"
    },
    {
      subnet_name           = "subnet-public" # there's no public/private snet concept in gcloud. Adding this just to try to split servers with public ips attached making visualization easier.
      subnet_ip             = var.vpc__subnet_public_cidr
      subnet_region         = var.region
      subnet_private_access = "true"
    },
    {
      subnet_name           = "subnet-private"
      subnet_ip             = var.vpc__subnet_private_cidr
      subnet_region         = var.region
      subnet_private_access = "true"
    },
  ]

  secondary_ranges = {
    subnet-gke = [
      {
        range_name    = "subnet-gke-pods"
        ip_cidr_range = var.vpc__subnet_gke_pods_cidr
      },
      {
        range_name    = "subnet-gke-services"
        ip_cidr_range = var.vpc__subnet_gke_service_cidr
      }
    ]
  }
}

# nat + router
resource "google_compute_router" "router" {
  name    = "${var.project_id}-${var.environment}-router-${var.region}"
  network = module.vpc.network_name
}

module "cloud-nat" {
  source        = "terraform-google-modules/cloud-nat/google"
  version       = "1.2.0"
  project_id    = "${var.project_id}"
  region        = "${var.region}"
  name          = "${var.project_id}-${var.environment}-nat-${var.region}"
  router        = google_compute_router.router.name
  network       = module.vpc.network_name
}
