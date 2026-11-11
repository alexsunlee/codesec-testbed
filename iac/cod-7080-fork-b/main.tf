# COD-7080 fixture: a PR from a fork that does not have the target branch.
resource "aws_s3_bucket" "cod_7080_fork_b" {
  bucket = "cod-7080-fixture-fork-b"
  acl    = "public-read"
}
