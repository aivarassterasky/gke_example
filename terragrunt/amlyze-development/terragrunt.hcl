remote_state {
  disable_dependency_optimization = true
  backend                         = "gcs"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }

  config = {
    bucket   = "amlyze-dev-terraform-remotestate"
    prefix   = "${path_relative_to_include()}/terraform.tfstate"
    project  = "amlyze-development"
    location = "europe-west1"
  }
}

locals {
  default_yaml_path = find_in_parent_folders("empty.yaml")
}

# Configure root level variables that all resources can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.
inputs = merge(
  # Configure Terragrunt to use common vars encoded as yaml to help you keep often-repeated variables (e.g., account ID)
  # DRY. We use yamldecode to merge the maps into the inputs, as opposed to using varfiles due to a restriction in
  # Terraform >=0.12 that all vars must be defined as variable blocks in modules. Terragrunt inputs are not affected by
  # this restriction.
  yamldecode(
    file("${find_in_parent_folders("defaults.yaml", local.default_yaml_path)}"),
  ),
  yamldecode(
    file("${find_in_parent_folders("env.yaml", local.default_yaml_path)}"),
  )
)

