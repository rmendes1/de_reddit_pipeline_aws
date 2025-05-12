output "s3_user_key" {
  value     = aws_iam_access_key.s3_key.id
  sensitive = true
}

output "s3_user_secret" {
  value     = aws_iam_access_key.s3_key.secret
  sensitive = true
}

output "glue_user_key" {
  value     = aws_iam_access_key.glue_key.id
  sensitive = true
}

output "glue_user_secret" {
  value     = aws_iam_access_key.glue_key.secret
  sensitive = true
}

output "athena_user_key" {
  value     = aws_iam_access_key.athena_key.id
  sensitive = true
}

output "athena_user_secret" {
  value     = aws_iam_access_key.athena_key.secret
  sensitive = true
}

output "redshift_user_key" {
  value     = aws_iam_access_key.redshift_key.id
  sensitive = true
}

output "redshift_user_secret" {
  value     = aws_iam_access_key.redshift_key.secret
  sensitive = true
}
