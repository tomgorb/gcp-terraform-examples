resource "google_storage_bucket" "export_bucket" {
  location = "EU"
  name     = var.export_bucket

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 1
    }
  }
}

resource "google_storage_bucket" "source_archive_bucket" {
  location = "EU"
  name     = var.source_archive_bucket
}
