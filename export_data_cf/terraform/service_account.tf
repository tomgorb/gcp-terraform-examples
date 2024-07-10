resource "google_service_account" "api_service_account" {
  account_id   = lower(var.service_account_name)
  display_name = "export_data cloud function service account"
  description  = "Service account used by the export_data cloud function to unload data to cloud storage"
  project      = var.project_id
}

resource "google_service_account_key" "api_service_account_key" {
  service_account_id = google_service_account.api_service_account.name
}

resource "google_project_iam_member" "bigquery_job_user" {
  member  = "serviceAccount:${google_service_account.api_service_account.email}"
  project = var.project_id
  role    = "roles/bigquery.jobUser"
}

resource "google_project_iam_member" "bigquery_ro_access" {
  member = "serviceAccount:${google_service_account.api_service_account.email}"
  project = var.project_id
  role   = "roles/bigquery.dataViewer"
}

resource "google_storage_bucket_iam_member" "storage_rw_access" {
  member = "serviceAccount:${google_service_account.api_service_account.email}"
  bucket = google_storage_bucket.export_bucket.id
  role   = "roles/storage.objectAdmin"
}
