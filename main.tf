terraform {
  required_version = ">= 0.12.1"
}

locals {
  keybase_fqn = format("keybase:%s", var.keybase)
}

module "user" {
  source        = "git::https://github.com/cloudposse/terraform-aws-iam-user.git?ref=tags/0.1.1"
  name          = var.username
  groups        = var.groups
  path          = var.path
  pgp_key       = local.keybase_fqn
  force_destroy = true
}

