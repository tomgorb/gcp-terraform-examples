variable "project_id" {
  type        = string
  description = "Project ID where the cloud function will run"
}

variable "function_name" {
  type        = string
  description = "Name of the cloud function"
  default     = "export_data"
}

variable "ingress_settings" {
  type        = string
  description = "ALLOW_ALL or ALLOW_INTERNAL_ONLY or ALLOW_INTERNAL_AND_GCLB"
  default     = "ALLOW_INTERNAL_ONLY"
  validation {
    condition     = contains(["ALLOW_ALL", "ALLOW_INTERNAL_ONLY", "ALLOW_INTERNAL_AND_GCLB"], var.ingress_settings)
    error_message = "Not a valid ingress setting."
  }
}

variable "export_bucket" {
  type        = string
  description = "Bucket used to store data exports"
}

variable "source_archive_bucket" {
  type        = string
  description = "Bucket containing the cloud function's sources"
}

variable "service_account_name" {
  type        = string
  description = "Name of the service account used by the cloud function"
  default     = "export-data-cf"
}

variable "app_version" {
  type        = string
  description = "Version number to be deployed, will be shown in the CF's name. Should be provided by terragrunt in a normal workflow"
}
