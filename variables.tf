
variable "username" {
  type        = string
  description = "The IAM username to use for this user"
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

variable "ssh_rsa_bits" {
  default     = 4096
  description = "Size of the generated RSA key for SSH"
}

variable "path" {
  type        = string
  default     = ""
  description = "The path under which the user should be created"
}
