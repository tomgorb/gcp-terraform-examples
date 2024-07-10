data "archive_file" "function_dist" {
  type        = "zip"
  source_dir  = "src"
  output_path = "${var.function_name}-${var.app_version}.zip"
}

resource "google_storage_bucket_object" "source_bucket" {
  name   = "${var.function_name}-${var.app_version}.zip"
  bucket = google_storage_bucket.source_archive_bucket.name
  source = data.archive_file.function_dist.output_path
}
