# IaC fixture - AWS S3. Planted misconfigurations:
#   public-read ACL, no server-side encryption, no versioning,
#   no access logging, no public-access block.

resource "aws_s3_bucket" "artifacts" {
  bucket = "codesec-testbed-artifacts"
}

# Public read on a bucket that holds build artifacts.
resource "aws_s3_bucket_acl" "artifacts" {
  bucket = aws_s3_bucket.artifacts.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "artifacts" {
  bucket = aws_s3_bucket.artifacts.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = "*"
      Action    = "s3:GetObject"
      Resource  = "${aws_s3_bucket.artifacts.arn}/*"
    }]
  })
}

# The same bucket done correctly, so over-reporting is visible.
resource "aws_s3_bucket" "compliant" {
  bucket = "codesec-testbed-compliant"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "compliant" {
  bucket = aws_s3_bucket.compliant.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "compliant" {
  bucket                  = aws_s3_bucket.compliant.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
