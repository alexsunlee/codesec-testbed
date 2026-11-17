# IaC fixture - Terraform modules (COD-7432). Every planted misconfiguration is inside a
# module, so each finding has to come back at a `module.` address:
#   a module called twice, a module with for_each, a module with count,
#   and modules nested three deep (platform -> storage -> kms).

module "logs" {
  source = "./modules/storage"
  name   = "${var.prefix}-logs"
}

module "backups" {
  source = "./modules/storage"
  name   = "${var.prefix}-backups"
}

module "tenant" {
  for_each = toset(var.tenants)
  source   = "./modules/storage"
  name     = "${var.prefix}-${each.key}"
}

module "edge" {
  count      = var.edge_count
  source     = "./modules/network"
  name       = "${var.prefix}-edge-${count.index}"
  admin_cidr = var.admin_cidr
}

module "platform" {
  source     = "./modules/platform"
  prefix     = var.prefix
  admin_cidr = var.admin_cidr
}
