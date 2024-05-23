<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.1 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.47.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | >= 4.47.0 |
| <a name="requirement_mysql"></a> [mysql](#requirement\_mysql) | 3.0.60 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 4.47.0 |
| <a name="provider_mysql"></a> [mysql](#provider\_mysql) | 3.0.60 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_project_iam_member.additive](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_sql_user.users](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user) | resource |
| [mysql_grant.grants](https://registry.terraform.io/providers/petoju/mysql/3.0.60/docs/resources/grant) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance"></a> [instance](#input\_instance) | (Required) The name of the Cloud SQL instance. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_mysql_endpoint"></a> [mysql\_endpoint](#input\_mysql\_endpoint) | (Required) The address of the MySQL server to use. Most often a 'hostname:port' pair, but may also be an absolute path to a Unix socket when the host OS is Unix-compatible. Can also be sourced from the MYSQL\_ENDPOINT environment variable. | `string` | n/a | yes |
| <a name="input_mysql_password"></a> [mysql\_password](#input\_mysql\_password) | (Optional) Password for the given user, if that user has a password | `string` | n/a | yes |
| <a name="input_mysql_username"></a> [mysql\_username](#input\_mysql\_username) | (Required) Username to use to authenticate with the server | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The ID of the project where this instances will be created. | `string` | n/a | yes |
| <a name="input_users"></a> [users](#input\_users) | <user> = {<br>        email = "<user email>"<br>        roles = ["roles/cloudsql.client","roles/cloudsql.instanceUser"]<br>        grants = [{<br>            database = "<database name>"<br>            permissions = ["SELECT", "INSERT", "UPDATE", "DELETE", "CREATE", "ALTER", "INDEX", "LOCK TABLES", "CREATE VIEW", "SHOW VIEW", "TRIGGER", "REFERENCES", "EVENT", "EXECUTE"] <br>        },<br>        {<br>            database = "<another database name>"<br>            permissions = ["SELECT"] <br>        }] <br>    },<br>    <another user> = {<br>        email = "<user email>"<br>        roles = ["roles/cloudsql.client","roles/cloudsql.instanceUser"]<br>        grants = [{<br>            database = "<database name>"<br>            permissions = [<list of permissions>] <br>        },  <br>    } | <pre>map(object({<br>    email = string<br>    host  = optional(string, "%")<br>    roles = optional(list(string),[])<br>    grants = list(object({<br>      database = string<br>      permissions = list(string)<br>    }))<br>  }))</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->