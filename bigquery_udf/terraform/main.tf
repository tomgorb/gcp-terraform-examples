module "multi_udf" {
  source        = "./modules/multi_udf"
  for_each      = toset(var.accounts_list)
  project_id    = each.value
  dataset_id    = var.dataset_id
  source_bucket = var.source_bucket
}
