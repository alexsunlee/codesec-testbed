variable "env" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "account_id" {
  type = string
}

variable "region" {
  type = string
}

variable "namespace" {
  type = string
}

variable "oidc_provider_arn" {
  type = string
}

variable "oidc_issuer" {
  type = string
}

variable "log_retention" {
  type = string
}

variable "bucket_arns" {
  type    = list(string)
  default = []
}

variable "kms_key_arns" {
  type    = list(string)
  default = []
}

variable "table_arns" {
  type    = list(string)
  default = []
}

variable "queue_arns" {
  type    = list(string)
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}
