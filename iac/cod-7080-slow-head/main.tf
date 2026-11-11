# COD-7080 fixture: an IaC change for the PR scan (SCA is disabled in the target branch, whose IaC scan is slow).
resource "aws_s3_bucket" "cod_7080_slow" {
  bucket = "cod-7080-fixture-slow"
  acl    = "public-read"
}
