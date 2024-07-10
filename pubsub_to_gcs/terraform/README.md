<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.55.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.76.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_storage_bucket.some_bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_iam_member.admin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |
| [null_resource.pubsub_subscription](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [google_project.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_gcs_name"></a> [gcs\_name](#input\_gcs\_name) | GCS target bucket | `string` | n/a | yes |
| <a name="input_lifecycle_days"></a> [lifecycle\_days](#input\_lifecycle\_days) | GCS lifecycle in days | `number` | `1` | no |
| <a name="input_project_archive"></a> [project\_archive](#input\_project\_archive) | GCP project archive. Default is GCP project ID | `string` | `""` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP project ID | `string` | n/a | yes |
| <a name="input_pubsub_topic_name"></a> [pubsub\_topic\_name](#input\_pubsub\_topic\_name) | Pub/Sub topic | `string` | n/a | yes |
| <a name="input_retention_period"></a> [retention\_period](#input\_retention\_period) | GCS retention period in seconds | `number` | `86400` | no |
| <a name="input_storage_class"></a> [storage\_class](#input\_storage\_class) | GCS storage class | `string` | `"STANDARD"` | no |
| <a name="input_trigger_local_exec"></a> [trigger\_local\_exec](#input\_trigger\_local\_exec) | Trigger local-exec | `bool` | `false` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->