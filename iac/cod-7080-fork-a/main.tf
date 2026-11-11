# COD-7080 fixture: a PR from a fork. The fork has the same target branch, whose codesec.yaml disables SCA.
resource "aws_s3_bucket" "cod_7080_fork_a" {
  bucket = "cod-7080-fixture-fork-a"
  acl    = "public-read"
}
