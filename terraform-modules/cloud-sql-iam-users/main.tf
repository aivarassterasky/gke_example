locals {
  user_database_permissions = flatten([
    for user in var.users : [
      for grant in user.grants : [
        { name = split("@", user.email)[0], database = grant.database, permissions = grant.permissions  }
      ]
    ]
  ])
  user_roles = flatten([
    for user in var.users : [
      for role in user.roles : [
        { name = split("@", user.email)[0], email = user.email, role = role }
      ]
    ]
  ])
}

resource "google_sql_user" "users" {
  for_each = var.users
  project  = var.project
  instance = var.instance
  name     = each.value.email
  type     = "CLOUD_IAM_USER"
}

resource "google_project_iam_member" "additive" {
  for_each = {
    for user in local.user_roles :
       "${user.name}-${user.role}" => user
  }
  project = var.project
  role    = each.value.role
  member  = "user:${each.value.email}"
}

resource "mysql_grant" "grants" {
  for_each = {
    for permissions in local.user_database_permissions :
    "${permissions.name}-${permissions.database}" => permissions
  }
  user       = each.value.name
  host       = "%"
  database   = each.value.database
  privileges = each.value.permissions
  depends_on = [google_sql_user.users]
}
