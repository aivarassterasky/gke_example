
terraform {
  source = "../../../terraform-modules/gke-cluster"
}
include {
  path   = find_in_parent_folders()
  expose = true
}
inputs = {
  sufix        = ""
  network      = "https://www.googleapis.com/compute/v1/projects/<project>/global/networks/<vpc name>"
  subnetwork   = "https://www.googleapis.com/compute/v1/projects/<project>/regions/<region>/subnetworks/<subnetwork name>"
  private_tag  = "private"
  machine_type = "e2-standard-4"
  preemptible  = false
  spot         = true
  node_locations = [
    "europe-west1-a",
    "europe-west1-b",
    "europe-west1-c",
  ]
  # Kubernetes master and nodes version can be set here
  kubernetes_nodes_version = "1.27.11-gke.1062000"
  kubernetes_version       = "1.27.11-gke.1062000"
  name = "amlyze" #vardas
  # Autoscaling variables
  nodepool_config = {
    autoscaling = {
      use_total_nodes = true
      min_node_count = 1
      max_node_count = 7
    }
    management = {
      auto_repair = true
      auto_upgrade = true
    }
  }

  enable_vertical_pod_autoscaling = true
  node_count                      = "1"
  # Additional GKE security values
  enable_private_nodes               = true
  enable_shielded_nodes              = true
  enable_binary_authorization        = false
  enable_workload_identity           = true
  enable_secrets_database_encryption = true
  # Annotations / labels
  cluster_resource_labels             = {}
  cluster_service_account_name        = "amlyze-dev-gke-sa"
  cluster_service_account_description = "amlyze-dev-gke-sa GKE Cluster Service Account managed by Terraform"
  enable_dataplane_v2                 = true
  master_ipv4_cidr_block              = "10.0.1.16/28" # pakeisti
  cluster_secondary_range_name        = "<pod range name>"
  service_secondary_range_name        = "<service range name>"
  labels = {
    private-pools = "true"
    spot = "true"
  }
  #Additional nodepool
  enable_gateway_api = true
  master_authorized_networks_config = [{
    cidr_blocks = [{
      cidr_block   = "0.0.0.0/0"
      display_name = "allow-master"
    }],
  }]
  extra_node_pools = [
    # {
    #   name             = "example"
    #   nodepool_config = {
    #     autoscaling = {
    #       use_total_nodes = true
    #       min_node_count = 0
    #       max_node_count = 3
    #     }
    #     management = {
    #       auto_repair = true
    #       auto_upgrade = true
    #     }
    #     labels = {
    #       private-pools = "true"
    #       spot = "true"
    #     }
    #   }
    #   nodepool_machine_type = "n2-standard-2"
    #   disk_size_gb         = "50"
    #   disk_type            = "pd-standard"
    #   nodepool_preemptible = false
    #   nodepool_spot        = true
    # },   
    # {
    #   name             = "example-pool-custom-8-16"
    #   nodepool_config = {
    #     autoscaling = {
    #       use_total_nodes = true
    #       min_node_count = 3
    #       max_node_count = 7
    #     }
    #     management = {
    #       auto_repair = true
    #       auto_upgrade = true
    #     }
    #     labels = {
    #       private-pools = "true"
    #       persistent = "true"
    #       size = "custom-8-16"
    #     }
    #   }
    #   nodepool_machine_type = "custom-8-16384"
    #   disk_size_gb         = "50"
    #   disk_type            = "pd-standard"
    #   nodepool_preemptible = false
    #   nodepool_spot        = false
    # }
  ]

  maintenance_start_time = "04:00"
  oauth_scopes = [
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/cloud_debugger",
    "https://www.googleapis.com/auth/devstorage.read_write",
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring",
    "https://www.googleapis.com/auth/service.management.readonly",
    "https://www.googleapis.com/auth/servicecontrol",
    "https://www.googleapis.com/auth/trace.append",

  ]
  service_account_roles = [
    "roles/storage.objectViewer",
    "roles/storage.objectCreator",
    "roles/storage.objectAdmin",
    "roles/cloudtrace.agent",
    "roles/artifactregistry.reader",
    "roles/cloudkms.cryptoKeyDecrypter",
    "roles/cloudkms.cryptoKeyEncrypter"
  ]
}
