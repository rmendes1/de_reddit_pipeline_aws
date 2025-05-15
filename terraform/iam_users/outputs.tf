output "s3_user_key" {
  value     = aws_iam_access_key.s3_key.id
  sensitive = true
}

output "s3_user_secret" {
  value     = aws_iam_access_key.s3_key.secret
  sensitive = true
}
