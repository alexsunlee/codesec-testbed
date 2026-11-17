variable "name" {
  type = string
}

# Planted: no encryption, no versioning, no access logging, no public-access block.
resource "aws_s3_bucket" "this" {
  bucket = var.name
}

module "kms" {
  source = "../kms"
  name   = var.name
}

module "db" {
  source = "../database"
  name   = var.name
}
