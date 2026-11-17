variable "name" {
  type = string
}

# Planted: publicly accessible, storage unencrypted, no backups, no enhanced monitoring,
# no query logging.
resource "aws_db_instance" "this" {
  identifier                  = "${var.name}-db"
  engine                      = "postgres"
  instance_class              = "db.t3.micro"
  allocated_storage           = 20
  username                    = "app"
  manage_master_user_password = true
  publicly_accessible         = true
  storage_encrypted           = false
  backup_retention_period     = 0
  skip_final_snapshot         = true
}
