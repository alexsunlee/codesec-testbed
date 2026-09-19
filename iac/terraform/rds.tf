# IaC fixture - managed database.
#   publicly reachable, storage unencrypted, no backups, no deletion
#   protection, and a password hard-coded in the plan (also a Secrets finding).

resource "aws_db_instance" "analytics" {
  identifier          = "codesec-testbed-analytics"
  engine              = "postgres"
  instance_class      = "db.t3.medium"
  allocated_storage   = 20
  username            = "svc_reporting"
  password            = "Pa55w0rd-CODESECTESTBED"
  publicly_accessible = true
  storage_encrypted   = false
  skip_final_snapshot = true
  deletion_protection = false
  backup_retention_period = 0
}
