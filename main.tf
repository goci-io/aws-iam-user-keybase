terraform {
  required_version = ">= 0.12.1"
  
  required_providers {
    aws      = "~> 2.25"
    tls      = "~> 2.1"
    external = "~> 1.2"
  }
}

locals {
  keybase_fqn = format("keybase:%s", var.keybase)
}

module "user" {
  # Fork from https://github.com/cloudposse/terraform-aws-iam-user
  # cloudposse module is not Terraform 0.12 compatible. 
  # TimJones source might fail at some point because of the branch being deleted.
  # Please check cloudposse source for new release including Terraform 0.12 compatibility. 
  # https://github.com/cloudposse/terraform-aws-iam-user/pull/3
  source                  = "git::https://github.com/TimJones/terraform-aws-iam-user.git?ref=update-to-tf-v0.12"
  name                    = var.username
  groups                  = var.groups
  path                    = var.path
  pgp_key                 = local.keybase_fqn
  force_destroy           = true
  password_reset_required = false
}
