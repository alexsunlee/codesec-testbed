locals {
  name_prefix        = "${var.env}-${var.cluster_name}"
  account_arn        = "arn:aws:iam::${var.account_id}"
  regional_arn       = "arn:aws:logs:${var.region}:${var.account_id}"
  oidc_sub_prefix    = "system:serviceaccount:${var.namespace}"
  oidc_sub_key       = "${var.oidc_issuer}:sub"
  oidc_aud_key       = "${var.oidc_issuer}:aud"
  log_group_prefix   = "${local.regional_arn}:log-group:/apps/${local.name_prefix}"
  bucket_object_arns = [for arn in var.bucket_arns : "${arn}/*"]
  all_bucket_arns    = concat(var.bucket_arns, local.bucket_object_arns)
  table_index_arns   = [for arn in var.table_arns : "${arn}/index/*"]
  all_table_arns     = concat(var.table_arns, local.table_index_arns)
  common_tags        = merge(var.tags, { cluster = var.cluster_name, env = var.env, prefix = local.name_prefix })
}
