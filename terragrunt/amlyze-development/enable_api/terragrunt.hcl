
terraform {
  source = "/Users/aivarassukackas/Documents/15min/terraform-modules/enable_apis"
}

include {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  services = [
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com",
    "iam.googleapis.com",
    "serviceusage.googleapis.com",
    "servicenetworking.googleapis.com",
    "cloudkms.googleapis.com"
  ]
}
