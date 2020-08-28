variable project_id {
  default = "fernando-tests"
}

variable region {
  default = "us-central1"
}

variable environment {
  default = "development"
}

variable office_ips {
  default = ["162.247.225.249/32"]
}

variable dns_zone_name {
  default = "fernando-tests"
}

variable dns_zone_addr {
  default = "fernando-tests.osmose.paytmlabs.com."
}

variable bastion__count {
  default = 1
}

variable bastion__instance_type {
  default = "f1-micro"
}
variable vpc__subnet_gke_cidr {}
variable vpc__subnet_gke_pods_cidr {}
variable vpc__subnet_gke_service_cidr {}
variable vpc__subnet_public_cidr {}
variable vpc__subnet_private_cidr {}

variable gks__master_cidr_block {
  default = "10.99.0.0/28"
}

variable gks__version {
  default = "latest"
}

variable gks__logging_service {
  default     = "logging.googleapis.com/kubernetes"
  description = "defaults to StackDriver, set to none to disable"
}

variable gks__monitoring_service {
  default     = "monitoring.googleapis.com/kubernetes"
  description = "defaults to StackDriver, set to none to disable"
}

variable zookeeper__count {
  default = 3
}

variable zookeeper__instance_type {
  default = "n1-standard-1"
}
variable zookeeper__disk_size {
  default = 30
}

variable cassandra__count {
  default = 3
}

variable cassandra__instance_type {
  default = "n1-highmem-4"
}
variable cassandra__disk_size {
  default = 50
}

variable kafka__count {
  default = 3
}

variable kafka__instance_type {
  default = "n1-highmem-4"
}
variable kafka__disk_size {
  default = 50
}

variable elasticsearch__count {
  default = 1
}

variable elasticsearch__instance_type {
  default = "n1-highmem-2"
}
variable elasticsearch__disk_size {
  default = 50
}

variable elasticsearch_client__count {
  default = 1
}

variable elasticsearch_client__instance_type {
  default = "n1-highmem-2"
}
variable elasticsearch_client__disk_size {
  default = 50
}

variable azkaban__count {
  default = 1
}

variable azkaban__instance_type {
  default = "n1-highmem-2"
}
variable azkaban__disk_size {
  default = 50
}
