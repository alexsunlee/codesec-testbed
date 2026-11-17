variable "name" {
  type = string
}

# Planted: key rotation is off.
resource "aws_kms_key" "this" {
  description         = "${var.name} data key"
  enable_key_rotation = false
}
