resource "google_bigquery_dataset" "sql_udfs" {
    dataset_id  = var.dataset_id
    description = "Dataset containing all UDFs"
    location    = "EU"
    project     = var.project_id
    labels = {
      "managed_by"  = "terraform"
  }
}

module "udfs" {
  source   = "../udfs"
  project_id         = var.project_id
  source_bucket      = var.source_bucket
  dataset_id         = google_bigquery_dataset.sql_udfs.dataset_id
}
