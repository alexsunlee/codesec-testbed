# COD-7080 fixture: an IaC change for the PR scan (IaC is disabled in the target branch).
resource "aws_s3_bucket" "cod_7080_iac" {
  bucket = "cod-7080-fixture-iac"
  acl    = "public-read"
}
