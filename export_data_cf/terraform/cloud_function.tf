locals {
  split_secret_name = split("/",
    google_secret_manager_secret_version.secret_service_account.id
  )
}
resource "google_cloudfunctions_function" "export_data" {
  name        = var.function_name
  runtime     = "python311"
  description = "Export some data from BigQuery to Cloud Storage and return a signed URL valid for 15 minutes"

  labels = {
    "managed_by" : "terraform",
  }

  region              = "europe-west1"
  available_memory_mb = 128
  entry_point         = "run"

  timeout                      = 60 * 5
  trigger_http                 = true
  https_trigger_security_level = "SECURE_ALWAYS"

  ingress_settings = var.ingress_settings

  service_account_email = google_service_account.api_service_account.email
  secret_environment_variables {
    key     = "SERVICE_ACCOUNT"
    secret  = element(local.split_secret_name, 3)
    version = google_secret_manager_secret_version.secret_service_account.version
  }

  environment_variables = {
    BUCKET_NAME = google_storage_bucket.export_bucket.name
    PROJECT_ID  = var.project_id
  }

  source_archive_bucket = google_storage_bucket_object.source_bucket.bucket
  source_archive_object = google_storage_bucket_object.source_bucket.name

  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }

}
