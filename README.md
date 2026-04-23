# terraform-aurora-private-cloud-environment

This module deploys the Aurora environment in GC Private Cloud.

## Usage

Examples for this module along with various configurations can be found in the [examples/](examples/) folder.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9 |
| <a name="requirement_openstack"></a> [openstack](#requirement\_openstack) | >= 3.0.0, < 4.0.0 |
| <a name="requirement_rancher2"></a> [rancher2](#requirement\_rancher2) | ~> 8.2 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_openstack"></a> [openstack](#provider\_openstack) | >= 3.0.0, < 4.0.0 |
| <a name="provider_rancher2"></a> [rancher2](#provider\_rancher2) | ~> 8.2 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_infrastructure"></a> [infrastructure](#module\_infrastructure) | git::https://github.com/gccloudone-aurora-iac/terraform-rancher-kubernetes-cluster.git | main |

## Resources

| Name | Type |
| ---- | ---- |
| [openstack_networking_network_v2.aurora_cluster](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/networking_network_v2) | resource |
| [openstack_networking_router_interface_v2.node_subnet](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/networking_router_interface_v2) | resource |
| [openstack_networking_subnet_v2.node_subnet](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/networking_subnet_v2) | resource |
| [rancher2_cluster_role_template_binding.cluster_operator](https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/cluster_role_template_binding) | resource |
| [openstack_networking_network_v2.external](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/data-sources/networking_network_v2) | data source |
| [openstack_networking_router_v2.default](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/data-sources/networking_router_v2) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the Rancher Cluster. | `list(string)` | n/a | yes |
| <a name="input_cluster_operators"></a> [cluster\_operators](#input\_cluster\_operators) | A list of Rancher user IDs to indicate the operators of the cluster. | `list(string)` | n/a | yes |
| <a name="input_dns_nameservers"></a> [dns\_nameservers](#input\_dns\_nameservers) | A list of DNS servers to advertise to clients on the network. | `list(string)` | n/a | yes |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | The Kubernetes version used by the control plane & the default version for the agent nodes. | `string` | n/a | yes |
| <a name="input_openstack_application_credential_id"></a> [openstack\_application\_credential\_id](#input\_openstack\_application\_credential\_id) | Application Credential ID used by Rancher to provision on OpenStack. | `any` | n/a | yes |
| <a name="input_openstack_application_credential_secret"></a> [openstack\_application\_credential\_secret](#input\_openstack\_application\_credential\_secret) | Application Credential Secret used by Rancher to provision on OpenStack. | `any` | n/a | yes |
| <a name="input_openstack_auth_url"></a> [openstack\_auth\_url](#input\_openstack\_auth\_url) | OpenStack Authentication URL | `any` | n/a | yes |
| <a name="input_openstack_domain_id"></a> [openstack\_domain\_id](#input\_openstack\_domain\_id) | Domain ID of the OpenStack tenant where to deploy the cluster.. | `any` | n/a | yes |
| <a name="input_openstack_project_id"></a> [openstack\_project\_id](#input\_openstack\_project\_id) | Project ID of the OpenStack project where to deploy the cluster. | `any` | n/a | yes |
| <a name="input_openstack_region"></a> [openstack\_region](#input\_openstack\_region) | OpenStack region where to deploy the cluster. | `any` | n/a | yes |
| <a name="input_router_name"></a> [router\_name](#input\_router\_name) | The name of the router to attach to the Vault cluster subnet. | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to assign to the OpenStack resources | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## History

| Date       | Release | Change                                                                              |
| ---------- | ------- | ----------------------------------------------------------------------------------- |
| 2026-01-25 | v0.0.1  | initial commit                                                                      |
