variable "prefix" {
  type    = string
  default = "codesec-testbed"
}

variable "tenants" {
  type    = list(string)
  default = ["alpha"]
}

variable "edge_count" {
  type    = number
  default = 1
}

# The planted value: admin access from anywhere.
variable "admin_cidr" {
  type    = string
  default = "0.0.0.0/0"
}
