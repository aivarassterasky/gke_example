# GKE module

This module create GKE with two secondary subnets for POD network and Service network.
Also create required service accounts and node pool.

TODO
- Add timeout after GKE management plane deployment because it doesn't wait till cluster status is ready (Node pool created after second terragrunt apply).
- Add variable to stict access to management plain, now it's allowed from 0.0.0.0/0



<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.26 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | n/a |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gke_service_account"></a> [gke\_service\_account](#module\_gke\_service\_account) | github.com/gruntwork-io/terraform-google-gke.git//modules/gke-service-account | v0.3.8 |

## Resources

| Name | Type |
|------|------|
| [google-beta_google_container_node_pool.node_pool](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_container_node_pool) | resource |
| [google_container_cluster.cluster](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster) | resource |
| [google_kms_crypto_key.cluster-encryption-key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key) | resource |
| [google_kms_key_ring.keyring](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_key_ring) | resource |
| [google_project_iam_member.service_account-roles](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [kubernetes_storage_class.regionalpd-storageclass](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/storage_class) | resource |
| [local_file.ca](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [null_resource.k8s_sc_patcher](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [time_sleep.wait_30_seconds](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [google_client_config.provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |
| [google_compute_zones.available](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_zones) | data source |
| [google_container_engine_versions.location](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/container_engine_versions) | data source |
| [google_project.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |
| [google_service_account.kubernetes-service-agent](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/service_account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alternative_default_service_account"></a> [alternative\_default\_service\_account](#input\_alternative\_default\_service\_account) | Alternative Service Account to be used by the Node VMs. If not specified, the default compute Service Account will be used. Provide if the default Service Account is no longer available. | `string` | `null` | no |
| <a name="input_basic_auth_password"></a> [basic\_auth\_password](#input\_basic\_auth\_password) | The password used for basic auth; set both this and `basic_auth_username` to "" to disable basic auth. | `string` | `""` | no |
| <a name="input_basic_auth_username"></a> [basic\_auth\_username](#input\_basic\_auth\_username) | The username used for basic auth; set both this and `basic_auth_password` to "" to disable basic auth. | `string` | `""` | no |
| <a name="input_cluster_secondary_range_name"></a> [cluster\_secondary\_range\_name](#input\_cluster\_secondary\_range\_name) | Predefined range name for the cluster pod IPs. | `string` | n/a | yes |
| <a name="input_cluster_service_account_description"></a> [cluster\_service\_account\_description](#input\_cluster\_service\_account\_description) | A description of the custom service account used for the GKE cluster. | `string` | `"Example GKE Cluster Service Account managed by Terraform"` | no |
| <a name="input_cluster_service_account_name"></a> [cluster\_service\_account\_name](#input\_cluster\_service\_account\_name) | The name of the custom service account used for the GKE cluster. This parameter is limited to a maximum of 28 characters. | `string` | `"example-private-cluster-sa"` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the cluster | `string` | `""` | no |
| <a name="input_disable_public_endpoint"></a> [disable\_public\_endpoint](#input\_disable\_public\_endpoint) | Control whether the master's internal IP address is used as the cluster endpoint. If set to 'true', the master can only be accessed from internal IP addresses. | `bool` | `false` | no |
| <a name="input_enable_client_certificate_authentication"></a> [enable\_client\_certificate\_authentication](#input\_enable\_client\_certificate\_authentication) | Whether to enable authentication by x509 certificates. With ABAC disabled, these certificates are effectively useless. | `bool` | `false` | no |
| <a name="input_enable_dataplane_v2"></a> [enable\_dataplane\_v2](#input\_enable\_dataplane\_v2) | Whether to enable Kubernetes Dataplane V2 . | `bool` | `true` | no |
| <a name="input_enable_legacy_abac"></a> [enable\_legacy\_abac](#input\_enable\_legacy\_abac) | Whether to enable legacy Attribute-Based Access Control (ABAC). RBAC has significant security advantages over ABAC. | `bool` | `false` | no |
| <a name="input_enable_private_nodes"></a> [enable\_private\_nodes](#input\_enable\_private\_nodes) | Control whether nodes have internal IP addresses only. If enabled, all nodes are given only RFC 1918 private addresses and communicate with the master via private networking. | `bool` | `false` | no |
| <a name="input_enable_secrets_database_encryption"></a> [enable\_secrets\_database\_encryption](#input\_enable\_secrets\_database\_encryption) | Enable encryption of secrets in etcd, e.g: projects/my-project/locations/global/keyRings/my-ring/cryptoKeys/my-key | `bool` | `true` | no |
| <a name="input_enable_vertical_pod_autoscaling"></a> [enable\_vertical\_pod\_autoscaling](#input\_enable\_vertical\_pod\_autoscaling) | Whether to enable Vertical Pod Autoscaling | `string` | `false` | no |
| <a name="input_enable_workload_identity"></a> [enable\_workload\_identity](#input\_enable\_workload\_identity) | Enable Workload Identity on the cluster | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | Environment name where custer is deployed | `string` | n/a | yes |
| <a name="input_gsuite_domain_name"></a> [gsuite\_domain\_name](#input\_gsuite\_domain\_name) | The domain name for use with Google security groups in Kubernetes RBAC. If a value is provided, the cluster will be initialized with security group `gke-security-groups@[yourdomain.com]`. | `string` | `null` | no |
| <a name="input_horizontal_pod_autoscaling"></a> [horizontal\_pod\_autoscaling](#input\_horizontal\_pod\_autoscaling) | Whether to enable the horizontal pod autoscaling addon | `bool` | `true` | no |
| <a name="input_http_load_balancing"></a> [http\_load\_balancing](#input\_http\_load\_balancing) | Whether to enable the http (L7) load balancing addon | `bool` | `true` | no |
| <a name="input_identity_namespace"></a> [identity\_namespace](#input\_identity\_namespace) | Workload Identity Namespace. Default sets project based namespace [project\_id].svc.id.goog | `string` | `null` | no |
| <a name="input_ip_masq_link_local"></a> [ip\_masq\_link\_local](#input\_ip\_masq\_link\_local) | Whether to masquerade traffic to the link-local prefix (169.254.0.0/16). | `bool` | `false` | no |
| <a name="input_ip_masq_resync_interval"></a> [ip\_masq\_resync\_interval](#input\_ip\_masq\_resync\_interval) | The interval at which the agent attempts to sync its ConfigMap file from the disk. | `string` | `"60s"` | no |
| <a name="input_kubernetes_nodes_version"></a> [kubernetes\_nodes\_version](#input\_kubernetes\_nodes\_version) | Kubernetes version for worker nodes. | `string` | `"latest"` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | The Kubernetes version of the masters. If set to 'latest' it will pull latest available version in the selected region. | `string` | `"latest"` | no |
| <a name="input_location"></a> [location](#input\_location) | The location (region or zone) to host the cluster in | `string` | n/a | yes |
| <a name="input_logging_service"></a> [logging\_service](#input\_logging\_service) | The logging service that the cluster should write logs to. Available options include logging.googleapis.com/kubernetes, logging.googleapis.com (legacy), and none | `string` | `"logging.googleapis.com/kubernetes"` | no |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | Type of machines to use on cluster node-private-pool. | `string` | `"n1-standard-1"` | no |
| <a name="input_maintenance_start_time"></a> [maintenance\_start\_time](#input\_maintenance\_start\_time) | Time window specified for daily maintenance operations in RFC3339 format | `string` | `"05:00"` | no |
| <a name="input_management_auto_repair"></a> [management\_auto\_repair](#input\_management\_auto\_repair) | Do we enable auto repair of node-pool nodes. | `bool` | `true` | no |
| <a name="input_management_auto_upgrade"></a> [management\_auto\_upgrade](#input\_management\_auto\_upgrade) | Do we enable auto upgrade of node-pool nodes. | `bool` | `true` | no |
| <a name="input_master_authorized_networks_config"></a> [master\_authorized\_networks\_config](#input\_master\_authorized\_networks\_config) | The desired configuration options for master authorized networks. Omit the nested cidr\_blocks attribute to disallow external access (except the cluster node IPs, which GKE automatically whitelists)<br>  ### example format ###<br>  master\_authorized\_networks\_config = [{<br>    cidr\_blocks = [{<br>      cidr\_block   = "10.0.0.0/8"<br>      display\_name = "example\_network"<br>    }],<br>  }] | `list(any)` | `[]` | no |
| <a name="input_master_ipv4_cidr_block"></a> [master\_ipv4\_cidr\_block](#input\_master\_ipv4\_cidr\_block) | The IP range in CIDR notation to use for the hosted master network. This range will be used for assigning internal IP addresses to the master or set of masters, as well as the ILB VIP. This range must not overlap with any other ranges in use within the cluster's network. | `string` | `""` | no |
| <a name="input_max_node_count"></a> [max\_node\_count](#input\_max\_node\_count) | n/a | `string` | n/a | yes |
| <a name="input_min_node_count"></a> [min\_node\_count](#input\_min\_node\_count) | n/a | `string` | n/a | yes |
| <a name="input_monitoring_service"></a> [monitoring\_service](#input\_monitoring\_service) | The monitoring service that the cluster should write metrics to. Automatically send metrics from pods in the cluster to the Stackdriver Monitoring API. VM metrics will be collected by Google Compute Engine regardless of this setting. Available options include monitoring.googleapis.com/kubernetes, monitoring.googleapis.com (legacy), and none | `string` | `"monitoring.googleapis.com/kubernetes"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the cluster | `string` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | A reference (self link) to the VPC network to host the cluster in | `string` | n/a | yes |
| <a name="input_network_project"></a> [network\_project](#input\_network\_project) | The project ID of the shared VPC's host (for shared vpc support) | `string` | `""` | no |
| <a name="input_node_count"></a> [node\_count](#input\_node\_count) | Count of nodes | `string` | `"3"` | no |
| <a name="input_node_locations"></a> [node\_locations](#input\_node\_locations) | The list of zones in which the cluster's nodes are located. Nodes must be in the region of their regional cluster or in the same region as their cluster's zone for zonal clusters. If this is specified for a zonal cluster, omit the cluster's zone. | `list(any)` | `[]` | no |
| <a name="input_non_masquerade_cidrs"></a> [non\_masquerade\_cidrs](#input\_non\_masquerade\_cidrs) | List of strings in CIDR notation that specify the IP address ranges that do not use IP masquerading. | `list(string)` | <pre>[<br>  "10.0.0.0/8",<br>  "172.16.0.0/12",<br>  "192.168.0.0/16"<br>]</pre> | no |
| <a name="input_oauth_scopes"></a> [oauth\_scopes](#input\_oauth\_scopes) | Oauth scopes to add for GKE Node pool | `list(any)` | `[]` | no |
| <a name="input_preemptible"></a> [preemptible](#input\_preemptible) | Do we run cheaper preemptible nodes. | `bool` | `false` | no |
| <a name="input_private_tag"></a> [private\_tag](#input\_private\_tag) | The name of private network tagß | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The project ID to host the cluster in | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region to host the cluster in | `string` | n/a | yes |
| <a name="input_resource_labels"></a> [resource\_labels](#input\_resource\_labels) | The GCE resource labels (a map of key/value pairs) to be applied to the cluster. | `map(any)` | `{}` | no |
| <a name="input_service_account_roles"></a> [service\_account\_roles](#input\_service\_account\_roles) | Service account roles for GKE Cluster | `list(any)` | `[]` | no |
| <a name="input_service_secondary_range_name"></a> [service\_secondary\_range\_name](#input\_service\_secondary\_range\_name) | Predefined range name for the cluster services IPs. | `string` | n/a | yes |
| <a name="input_spot"></a> [spot](#input\_spot) | Do we run cheaper spot nodes. | `bool` | `false` | no |
| <a name="input_stub_domains"></a> [stub\_domains](#input\_stub\_domains) | Map of stub domains and their resolvers to forward DNS queries for a certain domain to an external DNS server | `map(string)` | `{}` | no |
| <a name="input_subnetwork"></a> [subnetwork](#input\_subnetwork) | A reference (self link) to the subnetwork to host the cluster in | `string` | n/a | yes |
| <a name="input_sufix"></a> [sufix](#input\_sufix) | Sufix for naming. Default value is empty string | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_certificate"></a> [client\_certificate](#output\_client\_certificate) | Public certificate used by clients to authenticate to the cluster endpoint. |
| <a name="output_client_key"></a> [client\_key](#output\_client\_key) | Private key used by clients to authenticate to the cluster endpoint. |
| <a name="output_cluster_ca_certificate"></a> [cluster\_ca\_certificate](#output\_cluster\_ca\_certificate) | The public certificate that is the root of trust for the cluster. |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | The IP address of the cluster master. |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | The IP address of the cluster master. |
| <a name="output_master_version"></a> [master\_version](#output\_master\_version) | The Kubernetes master version. |
| <a name="output_name"></a> [name](#output\_name) | The name of the cluster master. This output is used for interpolation with node pools, other modules. |
<!-- END_TF_DOCS -->