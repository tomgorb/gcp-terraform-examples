resource "google_bigquery_routine" "md5_routine" {
  project         = var.project_id
  dataset_id      = var.dataset_id
  routine_id      = "md5"
  routine_type    = "SCALAR_FUNCTION"
  language        = "SQL"
  definition_body = <<-EOS
  IF
      (s IS NULL
        OR TRIM(s)='', NULL, TO_HEX(MD5(TRIM(s) )))
  EOS
  arguments {
    name      = "s"
    data_type = jsonencode({ "typeKind" : "STRING" })
  }

  return_type = jsonencode({ "typeKind" : "STRING" })
}
