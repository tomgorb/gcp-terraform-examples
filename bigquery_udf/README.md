# BIGQUERY UDF

Deploys [User Defined Functions](https://cloud.google.com/bigquery/docs/reference/standard-sql/user-defined-functions?hl=fr) to BigQuery.

# DEPLOYMENT

```
terraform plan
```
&rarr; review modifications
```
terraform apply
```

# UDF MODIFICATION
- All UDFs are stored in the `sql` directory of this repository, **as reference only!**.

### MAIN QUERY
- To modify an existing UDF, you must modify its code in the corresponding terraform file in the following directory: `terraform/modules/udfs`. Please respect this syntax:

```
resource "goole_bigquery_routine" "routine_name" {
  [...]
  definition_body = <<-EOS
  < your code goes here >
  EOS
  [...]
}
```

### OUTPUT
- To specify the type of the output of your UDF, use this syntax: 

```
resource "goole_bigquery_routine" "routine_name" {
  [...]
  return_type = jsonencode({ "typeKind" : < your type >})
  [...]
}
```

To see available types, please refer to the [terraform documentation](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_routine#return_type).

### ARGUMENTS
- To specify input arguments and their types, use this syntax:

```
resource "goole_bigquery_routine" "routine_name" {
  [...]
  arguments {
    name = < argument's name >
    data_type = jsonencode({ "typeKind" : < your type > })
  }
  [...]
}
```
You can use as much `arguments` blocks as needed.

To learn more about arguments, please refer to the [terraform documentation](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_routine#nested_arguments).

# TROUBLESHOOTING
> I'm getting errors about an unexpected keyword in my UDF:
Try to wrap the definition_body of your function in parentheses. For example, I had to wrap `atoz` UDF:

```
  definition_body = <<-EOS
  (WITH
    lookups AS (
    SELECT
    [...]
  ON
    char = accent)
  EOS
```