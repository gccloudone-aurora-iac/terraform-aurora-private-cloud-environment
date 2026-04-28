# Deploys Rancher Kubernetes Cluster and its related infrastructure.
#
# https://github.com/gccloudone-aurora-iac/terraform-rancher-kubernetes-cluster
#
module "infrastructure" {
  source = "git::https://github.com/gccloudone-aurora-iac/terraform-rancher-kubernetes-cluster.git?ref=main"

  openstack_application_credential_id     = var.openstack_application_credential_id
  openstack_application_credential_secret = var.openstack_application_credential_secret
  openstack_domain_id                     = var.openstack_domain_id
  openstack_project_id                    = var.openstack_project_id
  openstack_auth_url                      = var.openstack_auth_url
  openstack_region                        = var.openstack_region

  name = var.cluster_name

  network_id = openstack_networking_network_v2.aurora_cluster.id

  loadbalancer_network_id = openstack_networking_network_v2.aurora_cluster.id

  kubernetes_version = var.kubernetes_version

  control_pool = {
    name    = "system"
    flavour = "g4v-16"
    count   = 1
    labels = {
      "node.ssc-spc.gc.ca/use" = "general"
      "node.ssc-spc.gc.ca/purpose" = "system"
    }
    taints          = []
    security_groups = ["default"]
    volume_type     = "performance"
    volume_size     = 60
    roles           = ["etcd", "control"]
    network_id      = openstack_networking_network_v2.aurora_cluster.id
    subnet_id       = openstack_networking_subnet_v2.node_subnet.id
  }

  worker_pool = {
    name    = "general"
    flavour = "g4v-16"
    count   = 1
    labels = {
      "node.ssc-spc.gc.ca/use" = "general"
      "node.ssc-spc.gc.ca/purpose" = "general"
    }
    taints = [
      {
        key    = "CriticalAddonsOnly"
        value  = "true"
        effect = "NoSchedule"
      }
    ]
    security_groups = ["default"]
    volume_type     = "performance"
    volume_size     = 60
    roles           = ["worker"]
    network_id      = openstack_networking_network_v2.aurora_cluster.id
    subnet_id       = openstack_networking_subnet_v2.node_subnet.id
  }

  additional_pools = [{
    name    = "gateway"
    flavour = "g4v-16"
    count   = 1
    labels = {
      "node.ssc-spc.gc.ca/use" = "general"
      "node.ssc-spc.gc.ca/purpose" = "gateway"
    }
    taints = [
      {
        key    = "node.ssc-spc.gc.ca/purpose"
        value  = "gateway"
        effect = "NoSchedule"
      }
    ]
    security_groups = ["default"]
    volume_type     = "performance"
    volume_size     = 60
    roles           = ["worker"]
    network_id      = openstack_networking_network_v2.aurora_cluster.id
    subnet_id       = openstack_networking_subnet_v2.node_subnet.id
  }]
}

# Provides a Rancher v2 Cluster Role Template Binding resource.
#
# https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/cluster_role_template_binding
#
resource "rancher2_cluster_role_template_binding" "cluster_operator" {
  for_each         = toset(var.cluster_operators)
  name             = "crtb-cluster-owner-${each.key}"
  cluster_id       = module.infrastructure.cluster_v1_id
  role_template_id = "cluster-owner"
  user_id          = each.key
}
