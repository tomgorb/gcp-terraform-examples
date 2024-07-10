resource "null_resource" "pubsub_subscription" {

  triggers = {
    the_trigger = var.trigger_local_exec ? timestamp() : false
  }
  provisioner "local-exec" {
    command = var.trigger_local_exec ? join(" ",
      [
        "gcloud pubsub subscriptions create '${var.gcs_name}'",
        "--topic='${var.pubsub_topic_name}'",
        "--topic-project='${var.project_id}'",
        "--project='${var.project_id}'",
        "--cloud-storage-bucket='${var.gcs_name}'",
        "--cloud-storage-file-prefix=''",
        "--cloud-storage-file-suffix=.avro",
        "--cloud-storage-output-format=avro",
        "--cloud-storage-max-bytes=50MB",
        "--cloud-storage-max-duration=5m",
    ]) : "echo DO NOTHING"
  }

  depends_on = [google_storage_bucket_iam_member.admin]

}