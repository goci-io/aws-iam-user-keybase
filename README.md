# aws-iam-user-keybase

This module provisions a login profile and AWS IAM user. It requires a keybase user account to encrypt user password, SSH and Access-/Secret key.

### Usage

```hcl
module "user" {
  source     = "git::https://github.com/goci-io/aws-iam-user-keybase.git?ref=master"
  username   = "example"
  keybase    = "keybase_username"
  groups     = ["goci-sre", "goci-devs"]
}
```
