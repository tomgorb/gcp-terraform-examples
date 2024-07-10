resource "google_bigquery_routine" "sha256_routine" {
  project         = var.project_id
  dataset_id      = var.dataset_id
  routine_id      = "sha256"
  routine_type    = "SCALAR_FUNCTION"
  language        = "SQL"
  definition_body = <<-EOS
  IF
      (s IS NULL
        OR TRIM(s)='', NULL, TO_HEX(SHA256(TRIM(s) )))
  EOS
  arguments {
    name      = "s"
    data_type = jsonencode({ "typeKind" : "STRING" })
  }

  return_type = jsonencode({ "typeKind" : "STRING" })
}
