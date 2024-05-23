
variable "project" {
  description = "The ID of the project where this instances will be created."
  type        = string
}

variable "users" {
  description = <<EOF
    <user> = {
        email = "<user email>"
        roles = ["roles/cloudsql.client","roles/cloudsql.instanceUser"]
        grants = [{
            database = "<database name>"
            permissions = ["SELECT", "INSERT", "UPDATE", "DELETE", "CREATE", "ALTER", "INDEX", "LOCK TABLES", "CREATE VIEW", "SHOW VIEW", "TRIGGER", "REFERENCES", "EVENT", "EXECUTE"] 
        },
        {
            database = "<another database name>"
            permissions = ["SELECT"] 
        }] 
    },
    <another user> = {
        email = "<user email>"
        roles = ["roles/cloudsql.client","roles/cloudsql.instanceUser"]
        grants = [{
            database = "<database name>"
            permissions = [<list of permissions>] 
        },      
    }
  EOF
  type        = map(object({
    email = string
    host  = optional(string, "%")
    roles = optional(list(string),[])
    grants = list(object({
      database = string
      permissions = list(string)
    }))
  }))
}

variable "instance" {
  type = string
  description = "(Required) The name of the Cloud SQL instance. Changing this forces a new resource to be created."
}

variable "mysql_endpoint" {
  type = string
  description = " (Required) The address of the MySQL server to use. Most often a 'hostname:port' pair, but may also be an absolute path to a Unix socket when the host OS is Unix-compatible. Can also be sourced from the MYSQL_ENDPOINT environment variable."
}

variable "mysql_username" {
  type = string
  description = "(Required) Username to use to authenticate with the server" 
}

variable "mysql_password" {
  type = string
  description = "(Optional) Password for the given user, if that user has a password"
}