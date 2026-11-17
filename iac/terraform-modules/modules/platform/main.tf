variable "prefix" {
  type = string
}

variable "admin_cidr" {
  type = string
}

module "storage" {
  source = "../storage"
  name   = "${var.prefix}-platform"
}

module "network" {
  source     = "../network"
  name       = "${var.prefix}-platform"
  admin_cidr = var.admin_cidr
}
