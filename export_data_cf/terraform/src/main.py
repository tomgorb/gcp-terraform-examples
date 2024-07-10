import os
import json
import datetime
from google.cloud import bigquery, storage

def export_data_from_bq_to_gs(dataset, table):
    storage_client = storage.Client.from_service_account_info(json.loads(os.environ['SERVICE_ACCOUNT']))
    bq_client = bigquery.Client.from_service_account_info(json.loads(os.environ['SERVICE_ACCOUNT']))
    for blob in storage_client.list_blobs(os.environ["BUCKET_NAME"], prefix=table):
        blob.delete()

    query = """
            CREATE TEMP TABLE header AS (
              SELECT
                STRING_AGG(column_name, "|" ORDER BY ordinal_position) AS header
              FROM
              `%s.%s.INFORMATION_SCHEMA.COLUMNS`
              WHERE
                table_name = '%s');
            EXPORT DATA
              OPTIONS(uri = 'gs://%s/%s-header-*.csv.gz',
                overwrite = TRUE,
                compression='GZIP',
                format='CSV',
                header = FALSE,
                field_delimiter = ',') AS (
              SELECT
                *
              FROM
                header )
    """%(os.environ["PROJECT_ID"],dataset,table,os.environ["BUCKET_NAME"],table)
    query_job = bq_client.query(query=query, location="EU")
    query_job.result()

    query = """
            EXPORT DATA
              OPTIONS(uri = 'gs://%s/%s-*.csv.gz',
                overwrite = TRUE,
                compression='GZIP',
                format='CSV',
                header = FALSE,
                field_delimiter = '|') AS (
            SELECT
              * 
            FROM
              `%s.%s.%s`
        )
    """%(os.environ["BUCKET_NAME"],table,os.environ["PROJECT_ID"],dataset,table)
    query_job = bq_client.query(query=query, location="EU")
    query_job.result()

def generate_download_signed_url_v4(table):
    """Generates a v4 signed URL for downloading a blob.
    """
    storage_client = storage.Client.from_service_account_info(json.loads(os.environ['SERVICE_ACCOUNT']))
    blob = storage_client.bucket(os.environ["BUCKET_NAME"]).blob("%s.csv.gz"%table)
    blob.content_type = "text/plain"
    blobs = [blob for blob in sorted(storage_client.list_blobs(os.environ["BUCKET_NAME"], prefix=table), key=lambda blob: blob.name, reverse=True)]
    blob.compose(blobs)
    url = blob.generate_signed_url(
        version="v4",
        # This URL is valid for 15 minutes
        expiration=datetime.timedelta(minutes=15),
        # Allow GET requests using this URL.
        method="GET",
        response_disposition="attachment; filename=\"%s\""%blob.name
    )
    return url
    
def run(request):
    params=request.get_json()
    try:
      export_data_from_bq_to_gs(params.get('dataset'), params.get('table'))
      return generate_download_signed_url_v4(params.get('table'))
    except Exception:
      return "There was an error getting your file. Please try again later."
