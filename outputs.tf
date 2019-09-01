
output "username" {
  value = module.user.user_name
}

output "user_arn" {
  value = module.user.user_arn
}

output "access_key_id" {
  value = aws_iam_access_key.access_key.id
}

output "decrypt_password_command" {
  value = module.user.keybase_password_decrypt_command
}

output "decrypt_ssh_keys_command" {
  value = local.keybase_private_key_decrypt
}

output "decrypt_access_keys_command" {
  value = local.keybase_access_key_decrypt
}
