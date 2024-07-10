# CODE TO DEPLOY A CLOUD FUNCTION WHICH GENERATES A SIGNED URL TO DOWNLOAD THE CONTENT OF A BIGQUERY TABLE

## Requirements 

Mounted in environment variables
- **BUCKET_NAME**: a GCS bucket *myproject-tmp* with a TTL of 1 day 
- **PROJECT_ID**: *myproject* 

Mounted in secret environment variables
- **SERVICE_ACCOUNT**: a **service account** *export-data-cf@myproject.iam.gserviceaccount.com* with the following scope:
    - bigquery job user, bigquery viewer and storage object admin on *myproject*
    - roles/secretmanager.secretAccessor

The cloud function needs an authentication to be called (IAM role *cloudfunctions.functions.invoke*).

The cloud function needs 2 mandatory parameters:
- a **dataset** name
- a **table** name

The resulting file is a compressed (gzip) pipe (|) separated csv-like file with a header.

## Example

curl -m 310 -X POST https://europe-west1-myproject.cloudfunctions.net/export_data \
-H "Authorization: bearer $(gcloud auth print-identity-token)" \
-H "Content-Type: application/json" \
-d '{"dataset": "some_data_monitoring", "table": "billing"}'

### Note#1: This can take up to 2 minutes.

### Note#2 No need of a VPC connector.
