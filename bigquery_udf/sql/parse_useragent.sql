CREATE OR REPLACE FUNCTION
  `udfs.parse_useragent`(ua STRING)
  RETURNS STRUCT<browser_family STRING,
  device_brand STRING,
  device_model STRING>
  LANGUAGE js OPTIONS (library=["gs://{SOURCE_BUCKET}/ua-parser.min.js"]) AS R"""
let a = UAParser(ua);
  return {"browser_family": a.browser.name, "device_brand": a.device.vendor, "device_model": a.device.model};
""";
