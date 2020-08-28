variable "cluster_name" {
  description = "The name of the cluster, unique within the project and zoneData"
}

variable "project_id" {
  description = "The project in which the cluster will exist"
}

variable "region_name" {
  description = "The region in which the cluster and associated nodes will be created in"
}

variable "environment" {
  default = "development"
}

variable "labels" {
  description = "The list of labels (key/value pairs) to be applied to instances in the cluster"
  default     = {}
}

variable "master_num_instances" {
  description = "Specifies the number of master nodes to create"
  default     = 1
}

variable "master_machine_type" {
  description = "The name of a Google Compute Engine machine type to create for the master"
  default     = "n1-standard-4"
}

variable "master_boot_disk_size_gb" {
  description = "Size of the primary disk attached to each node, specified in GB"
  default     = 50
}

variable "worker_num_instances" {
  description = "Specifies the number of worker nodes to create"
  default     = 2
}

variable "worker_machine_type" {
  description = "The name of a Google Compute Engine machine type to create for the worker nodes"
  default     = "n1-highmem-4"
}

variable "worker_boot_disk_size_gb" {
  description = "Size of the primary disk attached to each worker node, specified in GB"
  default     = 30
}

variable "worker_boot_disk_type" {
  description = "Type of disk to use on worker nodes"
  default     = "pd-ssd"
}

variable "worker_num_local_ssd" {
  description = "Num of local SSD disks. Each disk has 375G and dataproc will use them for data"
  default     = 0
}

variable "preemptible_num_instances" {
  description = "Specifies the number of preemptible nodes to create"
  default     = 0
}

variable "image_version" {
  description = "The Cloud Dataproc image version to use for the clustere"
  default     = "1.4-debian9"
}

variable "network" {
  description = "network to install the cluster"
  default     = "default"
}

variable "subnetwork" {
  description = "subnetwork to install the cluster"
  default     = "default"
}

variable "zone" {
  description = "zone to install the cluster"
  default     = "us-central-1a"
}

variable "tags" {
  default = [""]
}
