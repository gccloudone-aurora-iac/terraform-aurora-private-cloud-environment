resource "openstack_networking_network_v2" "aurora_cluster" {
  name = "aurora-cluster"
}

resource "openstack_networking_subnet_v2" "node_subnet" {
    name = "node-snet"
    network_id = openstack_networking_network_v2.aurora_cluster.id
    ip_version = 4
    cidr = "10.1.10.0/24"
    gateway_ip = "10.1.10.1"

    dns_nameservers = var.dns_nameservers
}

resource "openstack_networking_router_interface_v2" "node_subnet" {
  router_id = data.openstack_networking_router_v2.default.id
  subnet_id = openstack_networking_subnet_v2.node_subnet.id
}
