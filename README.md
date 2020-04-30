# aws-iam-user-keybase

#### Maintained by [@goci-io/prp-terraform](https://github.com/orgs/goci-io/teams/prp-terraform)

![terraform](https://github.com/goci-io/aws-iam-user-keybase/workflows/terraform/badge.svg?branch=master)

This module provisions a login profile and AWS IAM user. It requires a keybase user account to encrypt user password and secret key.

__NOTE:__ This currently uses a submodule which is not Terraform 0.12 compatible. Tracked [here](https://github.com/cloudposse/terraform-aws-iam-user/pull/3). Therefore a temporary branch is used in the releases.

If you want to attach an SSH Key to the IAM user you will need to create a private and public key by your own. This is generally a better idea than having private keys stored even if they are encrypted and have limited permissions. If a public key is provided via `ssh_public_key` in ssh-rsa format it will be attached to the user automatically.

### Usage

```hcl
module "user" {
  source     = "git::https://github.com/goci-io/aws-iam-user-keybase.git?ref=tags/<latest-version>"
  username   = "example"
  keybase    = "keybase_username"
  groups     = ["goci-sre", "goci-devs"]
}
```

### Configuration

| Name | Description | Default |
|-----------------|----------------------------------------|---------|
| username | Name of the AWS user | - |
| keybase | Keybase user name | - |
| groups | Groups the user should be added to | `[]` |
| ssh_public_key | SSH Public key to add to the IAM user | `""` |
| create_access_key | If set to true generates IAM Access and Secret pair* | `false` |

_* It is generally recommended to let the user create their own secret pair and handle rotation etc. This also avoids having too many important secrets in the terraform state file_
