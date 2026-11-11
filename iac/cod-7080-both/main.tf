# COD-7080 fixture: an IaC change for the PR scan (SCA and IaC are disabled in the target branch).
resource "aws_s3_bucket" "cod_7080_both" {
  bucket = "cod-7080-fixture-both"
  acl    = "public-read"
}
