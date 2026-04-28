###########################
### OpenStack Resources ###
###########################

variable "openstack_application_credential_id" {
  description = "Application Credential ID used by Rancher to provision on OpenStack."
}

variable "openstack_application_credential_secret" {
  description = "Application Credential Secret used by Rancher to provision on OpenStack."

  sensitive = true
}

variable "openstack_domain_id" {
  description = "Domain ID of the OpenStack tenant where to deploy the cluster.."
}

variable "openstack_project_id" {
  description = "Project ID of the OpenStack project where to deploy the cluster."
}

variable "openstack_auth_url" {
  description = "OpenStack Authentication URL"
}

variable "openstack_region" {
  description = "OpenStack region where to deploy the cluster."
}

variable "tags" {
  description = "Tags to assign to the OpenStack resources"
  type        = map(string)
  default     = {}
}

######################################
### Rancher Cluster Infrastructure ###
######################################

variable "kubernetes_version" {
  description = "The Kubernetes version used by the control plane & the default version for the agent nodes."
  type        = string
}

variable "cluster_name" {
  description = "The name of the Rancher Cluster."
  type        = string
}

variable "cluster_operators" {
  description = "A list of Rancher user IDs to indicate the operators of the cluster."
  type        = list(string)
}

#######################
### Virtual Network ###
#######################

variable "dns_nameservers" {
  description = "A list of DNS servers to advertise to clients on the network."
  type        = list(string)
}

variable "network_prefixes" {
  description = "Map of network names and their corresponding IPv4 and IPv6 prefixes"
  type = map(object({
    prefixes_v4     = list(string)
    prefixes_v6     = list(string)
  }))
  default = {
    system = {
      prefixes_v4    = ["10.0.1.0/24"]
      prefixes_v6    = []
    }
    general = {
      prefixes_v4    = ["10.0.2.0/24"]
      prefixes_v6    = []
    }
    gateway = {
      prefixes_v4    = ["10.0.4.0/24"]
      prefixes_v6    = []
    }
    loadbalancer = {
      prefixes_v4    = ["10.0.6.0/24"]
      prefixes_v6    = []
    }
  }
}

###############################
### Platform Infrastructure ###
###############################

variable "router_name" {
  description = "The name of the router to attach to the Vault cluster subnet."
}
