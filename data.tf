data "openstack_networking_network_v2" "external" {
  name = "external"
}

data "openstack_networking_router_v2" "default" {
  name = var.router_name
}
