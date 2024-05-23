variable "project" {
  description = "(Required) The ID of the project where this instances will be created."
  type        = string
}

variable "cluster_location" {
  description = "(Required) The location where the alloydb cluster should reside."
  type = string
}

variable "cluster_id" {
  description = " (Required) The ID of the alloydb cluster."
  type = string 
}

variable "users" {
  description = <<EOF
GRANTS:
- role - (Required) The name of the role to grant privileges on, Set it to "public" for all roles.
- database - (Required) The database to grant privileges on for this role.
- schema - The database schema to grant privileges on for this role (Required except if object_type is "database")
- object_type - (Required) The PostgreSQL object type to grant the privileges on (one of: database, schema, table, sequence, function, procedure, routine, foreign_data_wrapper, foreign_server, column).
- privileges - (Required) The list of privileges to grant. There are different kinds of privileges: SELECT, INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER, CREATE, CONNECT, TEMPORARY, EXECUTE, and USAGE. An empty list could be provided to revoke all privileges for this role.
- objects - (Optional) The objects upon which to grant the privileges. An empty list (the default) means to grant permissions on all objects of the specified type. You cannot specify this option if the object_type is database or schema. When object_type is column, only one value is allowed.
 More info https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/postgresql_grant#objects
Example"
    "<user>" = {
        email = "<user email>"
        roles = ["roles/alloydb.databaseUser","roles/serviceusage.serviceUsageConsumer"]
        grants = [{
            database = "<database name>""
            role = "aivaras.s@terasky.com"
            schema = "public"
            object_type = "database"
            privileges = ["CONNECT"] 
        },
        {
            database = "testas"
            role = "aivaras.s@terasky.com"
            schema = "public"
            object_type = "table"
            objects = ["cars"]
            privileges = ["SELECT", "INSERT", "UPDATE", "DELETE", "TRUNCATE", "REFERENCES", "TRIGGER"] 
        }]
    },
    "<another user>" = {
        email = "<user email>"
        roles = ["roles/alloydb.databaseUser","roles/serviceusage.serviceUsageConsumer"]
        grants = [{
            database = "<database name>""
            role = "<user email>"
            schema = "public"
            object_type = "database"
            privileges = ["CONNECT"] 
        },
    }

EOF
  type        = map(object({
    email = string
    host  = optional(string, "%")
    roles = optional(list(string),[])
    grants = list(object({
      database = string
      role = string
      schema = string
      object_type = optional(string)
      objects = optional(list(string))
      privileges = list(string)
    }))

  }))
}


variable "postgresql_host" {
  description = "(Required) The address for the postgresql server connection, see GoCloud for specific format."
  type = string
}

variable "postgresql_port" {
  description = "(Optional) The port for the postgresql server connection. The default is 5432."
  type = string
  default = "5432"
}

variable "postgresql_database" {
  description = " (Optional) Database to connect to. The default is postgres."
  type = string
  default = "postgres"
}

variable "postgresql_username" {
  description = " (Required) Username for the server connection."
  type = string
}

variable "postgresql_password" {
  description = "(Required) Password for the server connection."
  type = string

}
variable "postgresql_sslmode" {
  description = <<EOF
  (Optional) Set the priority for an SSL connection to the server. Valid values for sslmode are (note: prefer is not supported by Go's lib/pq)):
disable - No SSL
require - Always SSL (the default, also skip verification)
verify-ca - Always SSL (verify that the certificate presented by the server was signed by a trusted CA)
verify-full - Always SSL (verify that the certification presented by the server was signed by a trusted CA and the server host name matches the one in the certificate) Additional information on the options and their implications can be seen in the libpq(3) SSL guide.
EOF
  type = string
  default = "disable"
}
