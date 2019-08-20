
locals {
  decrypt_template            = "echo \"%s\" | base64 --decode | keybase pgp decrypt"
  keybase_private_key_decrypt = format(local.decrypt_template, data.external.encrypt_ssh.result["key"])
  keybase_access_key_decrypt  = format(local.decrypt_template, aws_iam_access_key.access_key.encrypted_secret)
}

# AWS does not support DSA keys
# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html#how-to-generate-your-own-key-and-import-it-to-aws
resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = var.ssh_rsa_bits
}

resource "aws_iam_user_ssh_key" "iam_ssh" {
  encoding   = "SSH"
  username   = var.iam_username
  public_key = tls_private_key.key.public_key_openssh
}

resource "aws_iam_access_key" "access_key" {
  user    = module.user.user_name
  pgp_key = local.keybase_fqn
}

data "external" "encrypt_ssh" {
  program = ["/bin/bash", "${path.module}/scripts/keybase-encrypt.sh"]

  query = {
    keybase     = var.keybase
    private_key = tls_private_key.key.private_key_pem
  }
}
