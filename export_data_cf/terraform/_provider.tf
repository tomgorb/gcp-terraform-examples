terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.55.0"
    }
  }
}
provider "google" {
  project = var.project_id
  region  = "europe-west1"
}
