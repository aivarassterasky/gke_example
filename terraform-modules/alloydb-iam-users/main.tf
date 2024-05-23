locals {
  user_database_permissions = flatten([
    for user in var.users : [
      for grant in user.grants : [
        { name = split("@", user.email)[0], database = grant.database, role = grant.role, schema = grant.schema, object_type = grant.object_type, objects = grant.objects, privileges = grant.privileges   }
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

resource "google_project_iam_member" "additive" {
  for_each = {
    for user in local.user_roles :
       "${user.name}-${user.role}" => user
  }
  project = var.project
  role    = each.value.role
  member  = "user:${each.value.email}"
}

resource "google_alloydb_user" "user" {
  for_each = var.users
  cluster = "projects/${var.project}/locations/${var.cluster_location}/clusters/${var.cluster_id}"
  user_id = each.value.email
  user_type = "ALLOYDB_IAM_USER"

  database_roles = ["alloydbiamuser"]
  depends_on = [google_project_iam_member.additive]
}

resource "postgresql_grant" "grant" {
  for_each = {
    for permissions in local.user_database_permissions :
    "${permissions.name}-${permissions.database}-${permissions.role}-${permissions.object_type}" => permissions
  }
  database    = each.value.database
  role        = each.value.role
  schema      = each.value.schema
  object_type = each.value.object_type
  objects     = each.value.objects
  privileges  = each.value.privileges
  depends_on = [google_alloydb_user.user]
}