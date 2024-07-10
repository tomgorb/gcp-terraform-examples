resource "google_storage_bucket" "some_bucket" {
  name          = var.gcs_name
  project       = var.project_archive != "" ? var.project_archive : var.project_id
  location      = "EU"
  force_destroy = false
  storage_class = var.storage_class

  lifecycle_rule {
    condition {
      age = var.lifecycle_days
    }
    action {
      type = "Delete"
    }
  }
  retention_policy {
    is_locked        = false
    retention_period = var.retention_period
  }
}
