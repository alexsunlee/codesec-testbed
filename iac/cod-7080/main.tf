# COD-7080 fixture: an IaC change, so the IaC check has something to scan.
resource "aws_s3_bucket" "cod_7080" {
  bucket = "cod-7080-fixture"
  acl    = "public-read"
}
