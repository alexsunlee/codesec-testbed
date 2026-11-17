variable "name" {
  type = string
}

variable "admin_cidr" {
  type = string
}

# Planted: SSH open to admin_cidr, which the root module sets to 0.0.0.0/0.
resource "aws_security_group" "this" {
  name        = var.name
  description = "admin access"

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_cidr]
  }
}

# Planted: flow-log bucket with no lifecycle configuration and no event notifications.
resource "aws_s3_bucket" "flow_logs" {
  bucket = "${var.name}-flow-logs"
}
