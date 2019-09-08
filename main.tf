terraform {
  required_version = ">= 0.12.1"
}

provider "aws" {
  version = "~> 2.25"
}

locals {
  keybase_fqn                = format("keybase:%s", var.keybase)
  keybase_access_key_decrypt = format(local.decrypt_template, aws_iam_access_key.access_key.encrypted_secret)
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

resource "aws_iam_user_ssh_key" "iam_ssh" {
  count      = var.ssh_public_key == "" ? 0 : 1
  encoding   = "SSH"
  username   = module.user.user_name
  public_key = var.ssh_public_key
}

resource "aws_iam_access_key" "access_key" {
  user    = module.user.user_name
  pgp_key = local.keybase_fqn
}

