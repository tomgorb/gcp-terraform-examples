resource "google_project_service" "secretmanager" {
  provider = google
  service  = "secretmanager.googleapis.com"
}
resource "google_secret_manager_secret" "secret_service_account" {
  provider  = google
  secret_id = "export_data_service_account"
  replication {
    automatic = true
  }
  depends_on = [google_project_service.secretmanager]
}

resource "google_secret_manager_secret_version" "secret_service_account" {
  secret      = google_secret_manager_secret.secret_service_account.id
  secret_data = base64decode(google_service_account_key.api_service_account_key.private_key)
}

resource "google_secret_manager_secret_iam_member" "access_secret" {
  provider = google

  secret_id = google_secret_manager_secret.secret_service_account.id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_service_account.api_service_account.email}"
}