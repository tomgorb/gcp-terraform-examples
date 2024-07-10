variable "accounts_list" {
  type = list(string)
}

variable "dataset_id" {
  description = "ID of the dataset"
  type        = string
}

variable "source_bucket" {
  description = "Bucket containing the min.js file"
  type        = string
}