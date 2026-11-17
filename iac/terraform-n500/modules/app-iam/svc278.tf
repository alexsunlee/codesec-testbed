data "aws_iam_policy_document" "svc278_assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = [var.oidc_provider_arn]
    }
    condition {
      test     = "StringEquals"
      variable = local.oidc_sub_key
      values   = ["${local.oidc_sub_prefix}:svc278", "${local.oidc_sub_prefix}:svc278-worker"]
    }
    condition {
      test     = "StringEquals"
      variable = local.oidc_aud_key
      values   = ["sts.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "svc278" {
  statement {
    sid       = "Objects"
    effect    = "Allow"
    actions   = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"]
    resources = local.all_bucket_arns
  }
  statement {
    sid       = "Keys"
    effect    = "Allow"
    actions   = ["kms:Decrypt", "kms:GenerateDataKey"]
    resources = var.kms_key_arns
  }
  statement {
    sid       = "Tables"
    effect    = "Allow"
    actions   = ["dynamodb:GetItem", "dynamodb:PutItem", "dynamodb:Query"]
    resources = local.all_table_arns
  }
  statement {
    sid       = "Queues"
    effect    = "Allow"
    actions   = ["sqs:SendMessage", "sqs:ReceiveMessage", "sqs:DeleteMessage"]
    resources = var.queue_arns
  }
  statement {
    sid       = "Logs"
    effect    = "Allow"
    actions   = ["logs:CreateLogStream", "logs:PutLogEvents"]
    resources = ["${local.log_group_prefix}/svc278:*", "${local.log_group_prefix}/svc278-worker:*"]
  }
  statement {
    sid       = "AssumeSibling"
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = ["${local.account_arn}:role/${local.name_prefix}-svc278-reader"]
  }
}

resource "aws_iam_role" "svc278" {
  name               = "${local.name_prefix}-svc278"
  assume_role_policy = data.aws_iam_policy_document.svc278_assume.json
  tags               = local.common_tags
}

resource "aws_iam_policy" "svc278" {
  name   = "${local.name_prefix}-svc278"
  policy = data.aws_iam_policy_document.svc278.json
  tags   = local.common_tags
}

resource "aws_iam_role_policy_attachment" "svc278" {
  role       = aws_iam_role.svc278.name
  policy_arn = aws_iam_policy.svc278.arn
}
