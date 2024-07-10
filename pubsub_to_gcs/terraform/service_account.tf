data "google_project" "project" {
}

resource "google_storage_bucket_iam_member" "admin" {
  bucket     = google_storage_bucket.some_bucket.name
  role       = "roles/storage.admin"
  member     = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-pubsub.iam.gserviceaccount.com"
  depends_on = [google_storage_bucket.some_bucket]
}
