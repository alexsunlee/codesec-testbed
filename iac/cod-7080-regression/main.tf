# COD-7080 regression fixture: a PR to main, where no codesec.yaml disables a tool.
# Both the SCA and the IaC check must scan as before.
resource "aws_s3_bucket" "cod_7080_regression" {
  bucket = "cod-7080-regression-fixture"
  acl    = "public-read"
}
