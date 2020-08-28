provider "google" {
  version = "~> 3.3.0"
  region  = var.region
}

terraform {
  backend "gcs" {
    bucket = "fernando-tests"
    prefix = "terraform/state"
  }
}
