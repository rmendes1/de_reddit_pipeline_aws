# --- S3 User ---
resource "aws_iam_user" "s3_user" {
  name = "service-user-s3"
}

resource "aws_iam_user_policy" "s3_policy" {
  name = "s3-service-policy"
  user = aws_iam_user.s3_user.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "s3:*",
        Resource = [
          "arn:aws:s3:::${var.bucket_name}",
          "arn:aws:s3:::${var.bucket_name}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_access_key" "s3_key" {
  user = aws_iam_user.s3_user.name
}