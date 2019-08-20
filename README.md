# aws-iam-user-keybase

#### Maintained by [@goci-io/prp-terraform](https://github.com/orgs/goci-io/teams/prp-terraform)

This module provisions a login profile and AWS IAM user. It requires a keybase user account to encrypt user password, SSH and Access-/Secret key.

__NOTE:__ This currently uses a submodule which is not Terraform 0.12 compatible. Tracked [here](https://github.com/cloudposse/terraform-aws-iam-user/pull/3)

### Usage

```hcl
module "user" {
  source     = "git::https://github.com/goci-io/aws-iam-user-keybase.git?ref=master"
  username   = "example"
  keybase    = "keybase_username"
  groups     = ["goci-sre", "goci-devs"]
}
```
