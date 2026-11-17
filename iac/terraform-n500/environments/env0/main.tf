module "app_iam" {
  source = "../../modules/app-iam"

  env = var.env
  cluster_name = var.cluster_name
  account_id = var.account_id
  region = var.region
  namespace = var.namespace
  oidc_provider_arn = var.oidc_provider_arn
  oidc_issuer = var.oidc_issuer
  log_retention = var.log_retention
  bucket_arns = var.bucket_arns
  kms_key_arns = var.kms_key_arns
  table_arns = var.table_arns
  queue_arns = var.queue_arns
  tags = { team = "platform", root = "env0" }
}

data "aws_iam_policy_document" "wide" {
  statement {
    effect    = "Allow"
    actions   = ["s3:*", "iam:PassRole"]
    resources = ["*"]
  }
}
