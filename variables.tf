
variable "username" {
  type        = string
  description = "The IAM username to use for this user"
}

variable "ssh_public_key" {
  type = string
  default = ""
  description = "The SSH public key to attach to the IAM User in ssh-rsa format"
}

variable "keybase" {
  type        = string
  description = "The keybase username of this user"
}

variable "groups" {
  type        = list(string)
  default     = []
  description = "IAM Groups the user should be assigned to"
}

variable "path" {
  type        = string
  default     = "/"
  description = "The path under which the user should be created"
}
