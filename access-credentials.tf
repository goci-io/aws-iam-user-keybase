
locals {
  decrypt_template            = "echo \"%s\" | base64 --decode | keybase pgp decrypt"
  keybase_private_key_decrypt = format(local.decrypt_template, data.external.encrypt_ssh.result["key"])
  keybase_access_key_decrypt  = format(local.decrypt_template, aws_iam_access_key.access_key.encrypted_secret)
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

