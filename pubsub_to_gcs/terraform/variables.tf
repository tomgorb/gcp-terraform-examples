variable "project_id" {
  type        = string
  description = "GCP project ID"
}
variable "project_archive" {
  type        = string
  description = "GCP project archive. Default is GCP project ID"
  default     = ""
}
variable "storage_class" {
  type        = string
  description = "GCS storage class"
  default     = "STANDARD"
}
variable "lifecycle_days" {
  type        = number
  description = "GCS lifecycle in days"
  default     = 1
}
variable "retention_period" {
  type        = number
  description = "GCS retention period in seconds"
  default     = 86400
}
variable "gcs_name" {
  type        = string
  description = "GCS target bucket"
}
variable "pubsub_topic_name" {
  type        = string
  description = "Pub/Sub topic"
}
variable "trigger_local_exec" {
  type        = bool
  description = "Trigger local-exec"
  default     = false
}