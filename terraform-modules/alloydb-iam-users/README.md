<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.1 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.47.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | >= 4.47.0 |
| <a name="requirement_postgresql"></a> [postgresql](#requirement\_postgresql) | 1.22.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 4.47.0 |
| <a name="provider_postgresql"></a> [postgresql](#provider\_postgresql) | 1.22.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_alloydb_user.user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/alloydb_user) | resource |
| [google_project_iam_member.additive](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [postgresql_grant.grant](https://registry.terraform.io/providers/cyrilgdn/postgresql/1.22.0/docs/resources/grant) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_id"></a> [cluster\_id](#input\_cluster\_id) | (Required) The ID of the alloydb cluster. | `string` | n/a | yes |
| <a name="input_cluster_location"></a> [cluster\_location](#input\_cluster\_location) | (Required) The location where the alloydb cluster should reside. | `string` | n/a | yes |
| <a name="input_postgresql_database"></a> [postgresql\_database](#input\_postgresql\_database) | (Optional) Database to connect to. The default is postgres. | `string` | `"postgres"` | no |
| <a name="input_postgresql_host"></a> [postgresql\_host](#input\_postgresql\_host) | (Required) The address for the postgresql server connection, see GoCloud for specific format. | `string` | n/a | yes |
| <a name="input_postgresql_password"></a> [postgresql\_password](#input\_postgresql\_password) | (Required) Password for the server connection. | `string` | n/a | yes |
| <a name="input_postgresql_port"></a> [postgresql\_port](#input\_postgresql\_port) | (Optional) The port for the postgresql server connection. The default is 5432. | `string` | `"5432"` | no |
| <a name="input_postgresql_sslmode"></a> [postgresql\_sslmode](#input\_postgresql\_sslmode) | (Optional) Set the priority for an SSL connection to the server. Valid values for sslmode are (note: prefer is not supported by Go's lib/pq)):<br>disable - No SSL<br>require - Always SSL (the default, also skip verification)<br>verify-ca - Always SSL (verify that the certificate presented by the server was signed by a trusted CA)<br>verify-full - Always SSL (verify that the certification presented by the server was signed by a trusted CA and the server host name matches the one in the certificate) Additional information on the options and their implications can be seen in the libpq(3) SSL guide. | `string` | `"disable"` | no |
| <a name="input_postgresql_username"></a> [postgresql\_username](#input\_postgresql\_username) | (Required) Username for the server connection. | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | (Required) The ID of the project where this instances will be created. | `string` | n/a | yes |
| <a name="input_users"></a> [users](#input\_users) | GRANTS:<br>- role - (Required) The name of the role to grant privileges on, Set it to "public" for all roles.<br>- database - (Required) The database to grant privileges on for this role.<br>- schema - The database schema to grant privileges on for this role (Required except if object\_type is "database")<br>- object\_type - (Required) The PostgreSQL object type to grant the privileges on (one of: database, schema, table, sequence, function, procedure, routine, foreign\_data\_wrapper, foreign\_server, column).<br>- privileges - (Required) The list of privileges to grant. There are different kinds of privileges: SELECT, INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER, CREATE, CONNECT, TEMPORARY, EXECUTE, and USAGE. An empty list could be provided to revoke all privileges for this role.<br>- objects - (Optional) The objects upon which to grant the privileges. An empty list (the default) means to grant permissions on all objects of the specified type. You cannot specify this option if the object\_type is database or schema. When object\_type is column, only one value is allowed.<br> More info https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/postgresql_grant#objects<br>Example"<br>    "{user}" = {<br>        email = "{user email}"<br>        roles = ["roles/alloydb.databaseUser","roles/serviceusage.serviceUsageConsumer"]<br>        grants = [{<br>            database = "{database name}"<br>            role = "{user email}"<br>            schema = "public"<br>            object\_type = "database"<br>            privileges = ["CONNECT"] <br>        },<br>        {<br>            database = "testas"<br>            role = "{user email}"<br>            schema = "public"<br>            object\_type = "table"<br>            objects = ["cars"]<br>            privileges = ["SELECT", "INSERT", "UPDATE", "DELETE", "TRUNCATE", "REFERENCES", "TRIGGER"] <br>        }]<br>    },<br>    "{another user}" = {<br>        email = "{user email}"<br>        roles = ["roles/alloydb.databaseUser","roles/serviceusage.serviceUsageConsumer"]<br>        grants = [{<br>            database = "{database name}"<br>            role = "{user email}"<br>            schema = "public"<br>            object\_type = "database"<br>            privileges = ["CONNECT"] <br>        },<br>    } | <pre>map(object({<br>    email = string<br>    host  = optional(string, "%")<br>    roles = optional(list(string),[])<br>    grants = list(object({<br>      database = string<br>      role = string<br>      schema = string<br>      object_type = optional(string)<br>      objects = optional(list(string))<br>      privileges = list(string)<br>    }))<br><br>  }))</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->