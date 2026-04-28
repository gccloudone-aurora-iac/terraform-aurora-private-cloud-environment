# Deploys OpenStack network resources.
#
# https://github.com/gccloudone-aurora-iac/terraform-private-cloud-kubernetes-cluster
#
module "network_system" {
  source = "git::https://github.com/gccloudone-aurora-iac/terraform-private-cloud-openstack-network.git?ref=main"

  # We have to use just the instance here,
  # since there is a name length of 20 characters.
  name = "system"

  prefixes_v4 = var.network_prefixes["system"].prefixes_v4
  prefixes_v6 = []

  nameservers_v4 = var.dns_nameservers
  nameservers_v6 = []
}

# Manages a V2 router interface resource within OpenStack.
#
# https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/networking_router_interface_v2
#
resource "openstack_networking_router_interface_v2" "system" {
  for_each = module.network_system.subnet_ids

  router_id = data.openstack_networking_router_v2.default.id
  subnet_id = each.value
}

# Deploys OpenStack network resources.
#
# https://github.com/gccloudone-aurora-iac/terraform-private-cloud-kubernetes-cluster
#
module "network_general" {
  source = "git::https://github.com/gccloudone-aurora-iac/terraform-private-cloud-openstack-network.git?ref=main"

  # We have to use just the instance here,
  # since there is a name length of 20 characters.
  name = "general"

  prefixes_v4 = var.network_prefixes["general"].prefixes_v4
  prefixes_v6 = []

  nameservers_v4 = var.dns_nameservers
  nameservers_v6 = []
}

# Manages a V2 router interface resource within OpenStack.
#
# https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/networking_router_interface_v2
#
resource "openstack_networking_router_interface_v2" "general" {
  for_each = module.network_general.subnet_ids

  router_id = data.openstack_networking_router_v2.default.id
  subnet_id = each.value
}

# Deploys OpenStack network resources.
#
# https://github.com/gccloudone-aurora-iac/terraform-private-cloud-kubernetes-cluster
#
module "network_gateway" {
  source = "git::https://github.com/gccloudone-aurora-iac/terraform-private-cloud-openstack-network.git?ref=main"

  # We have to use just the instance here,
  # since there is a name length of 20 characters.
  name = "gateway"

  prefixes_v4 = var.network_prefixes["gateway"].prefixes_v4
  prefixes_v6 = []

  nameservers_v4 = var.dns_nameservers
  nameservers_v6 = []
}

# Manages a V2 router interface resource within OpenStack.
#
# https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/networking_router_interface_v2
#
resource "openstack_networking_router_interface_v2" "gateway" {
  for_each = module.network_gateway.subnet_ids

  router_id = data.openstack_networking_router_v2.default.id
  subnet_id = each.value
}

# Deploys OpenStack network resources.
#
# https://github.com/gccloudone-aurora-iac/terraform-private-cloud-kubernetes-cluster
#
module "network_loadbalancer" {
  source = "git::https://github.com/gccloudone-aurora-iac/terraform-private-cloud-openstack-network.git?ref=main"

  # We have to use just the instance here,
  # since there is a name length of 20 characters.
  name = "loadbalancer"

  prefixes_v4 = var.network_prefixes["loadbalancer"].prefixes_v4
  prefixes_v6 = []

  nameservers_v4 = var.dns_nameservers
  nameservers_v6 = []
}

# Manages a V2 router interface resource within OpenStack.
#
# https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/networking_router_interface_v2
#
resource "openstack_networking_router_interface_v2" "loadbalancer" {
  for_each = module.network_loadbalancer.subnet_ids

  router_id = data.openstack_networking_router_v2.default.id
  subnet_id = each.value
}
