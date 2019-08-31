terraform {
  required_version = ">= 0.12.1"
}

locals {
  keybase_fqn = format("keybase:%s", var.keybase)
}

module "user" {
  # Fork from https://github.com/cloudposse/terraform-aws-iam-user
  # cloudposse module is not Terraform 0.12 compatible. 
  # TimJones source might fail at some point. Please check cloudposse for new release
  # including Terraform 0.12 compatibility. 
  source        = "git::https://github.com/TimJones/terraform-aws-iam-user.git?ref=update-to-tf-v0.12"
  name          = var.username
  groups        = var.groups
  path          = var.path
  pgp_key       = local.keybase_fqn
  force_destroy = true
}
