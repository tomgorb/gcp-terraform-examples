resource "google_bigquery_routine" "birthday_routine" {
  project         = var.project_id
  dataset_id      = var.dataset_id
  routine_id      = "birthday"
  routine_type    = "SCALAR_FUNCTION"
  language        = "SQL"
  definition_body = <<-EOS
  IF
      (d IS NULL
        OR TRIM(CAST(d AS STRING))='', NULL, FORMAT(CASE
                WHEN t = 'day' THEN '%02d'
                WHEN t = 'month' THEN '%02d'
                WHEN t = 'year' THEN '%04d'
              ELSE
              NULL
            END
              ,
              CASE
                WHEN t = 'day' THEN EXTRACT(DAY FROM PARSE_DATE( IFNULL(NULLIF(CAST(f AS STRING), ""), "%Y-%m-%d"), TRIM(CAST(d AS STRING))))
                WHEN t = 'month' THEN EXTRACT(MONTH FROM PARSE_DATE( IFNULL(NULLIF(CAST(f AS STRING), ""), "%Y-%m-%d"), TRIM(CAST(d AS STRING))))
                WHEN t = 'year' THEN EXTRACT(YEAR FROM PARSE_DATE( IFNULL(NULLIF(CAST(f AS STRING), ""), "%Y-%m-%d"), TRIM(CAST(d AS STRING))))
              ELSE
              NULL
            END
              ))
  EOS
  arguments {
    name          = "d"
    argument_kind = "ANY_TYPE"
  }
  arguments {
    name          = "f"
    argument_kind = "ANY_TYPE"
  }
  arguments {
    name      = "t"
    data_type = jsonencode({ "typeKind" : "STRING" })
  }

  return_type = jsonencode({ "typeKind" : "STRING" })
}
