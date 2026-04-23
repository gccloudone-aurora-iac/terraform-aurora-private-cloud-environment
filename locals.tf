locals {
  tags = merge(var.tags, { ModuleName = "terraform-aurora-azure-private-cloud-environment" }, { ModuleVersion = "v0.0.1" })
}
