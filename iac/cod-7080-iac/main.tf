# COD-7080 fixture: an IaC change for the PR scan (IaC is disabled in the target branch).
resource "aws_s3_bucket" "cod_7080_iac" {
  bucket = "cod-7080-fixture-iac"
  acl    = "public-read"
}

# Second push: IaC is skipped while the SCA step really fails (its pod is evicted on both attempts).
resource "aws_s3_bucket" "cod_7080_iac_sca_fails" {
  bucket = "cod-7080-fixture-iac-sca-fails"
}

# Re-run with the final codesecbot image (c724457).
resource "aws_s3_bucket" "cod_7080_iac_final" {
  bucket = "cod-7080-iac-final"
}
