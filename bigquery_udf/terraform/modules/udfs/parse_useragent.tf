resource "google_bigquery_routine" "parse_useragent_routine" {
  project            = var.project_id
  dataset_id         = var.dataset_id
  routine_id         = "parse_useragent"
  routine_type       = "SCALAR_FUNCTION"
  language           = "JAVASCRIPT"
  imported_libraries = ["gs://${var.source_bucket}/ua-parser.min.js"]
  definition_body    = <<-EOS
  let a = UAParser(ua);
  return {"browser_family": a.browser.name, "device_brand": a.device.vendor, "device_model": a.device.model};
  EOS
  arguments {
    name      = "ua"
    data_type = jsonencode({ "typeKind" : "STRING" })
  }
  return_type = jsonencode({ "typeKind" : "STRUCT",
    "structType" : {
      "fields" : [
        { "name" : "browser_family", "type" : { "typeKind" : "STRING" } },
        { "name" : "device_brand", "type" : { "typeKind" : "STRING" } },
        { "name" : "device_model", "type" : { "typeKind" : "STRING" } }
      ]
    }
  })
}