module "cluster" {
  source = "git::https://github.com/gccloudone-aurora-iac/terraform-rancher-kubernetes-cluster?ref=main"

  name = "aurora-mgmt"

  application_credential_id=var.openstack_application_credential_id
  application_credential_secret=var.openstack_application_credential_secret


  domain_id=var.openstack_domain_id
  project_id=var.openstack_project_id
  auth_url=var.openstack_auth_url
  region=var.openstack_region

  network_id=openstack_networking_network_v2.aurora_cluster.id
  kubernetes_version=var.kubernetes_version

  control_pool={
      name    = "control"
      flavour = "g4v-16"
      count   = 1
      labels  = {

      }
      taints = []
      security_groups = ["default"]
      volume_type     = "performance"
      volume_size     = 60
      roles           = ["etcd", "control"]
      network_id      = openstack_networking_network_v2.aurora_cluster.id
      subnet_id = openstack_networking_subnet_v2.node_subnet.id
  }

  worker_pool={
      name    = "general"
      flavour = "g4v-16"
      count   = 1
      labels  = {
          "node.ssc-spc.gc.ca/use"="general"
      }
      taints = []
      security_groups = ["default"]
      volume_type     = "performance"
      volume_size     = 60
      roles           = ["worker"]
      network_id      = openstack_networking_network_v2.aurora_cluster.id
      subnet_id = openstack_networking_subnet_v2.node_subnet.id
  }
}

resource "rancher2_cluster_role_template_binding" "cluster_operator" {
  for_each = toset(var.cluster_operators)
  name = "crtb-cluster-owner-${each.key}"
  cluster_id = module.cluster.cluster_v1_id
  role_template_id = "cluster-owner"
  user_id = each.key
}
