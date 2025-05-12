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
          "arn:aws:s3:::reddit-pipeline-bckt",
          "arn:aws:s3:::reddit-pipeline-bckt/*"
        ]
      }
    ]
  })
}

resource "aws_iam_access_key" "s3_key" {
  user = aws_iam_user.s3_user.name
}

# --- Glue User ---
resource "aws_iam_user" "glue_user" {
  name = "service-user-glue"
}

resource "aws_iam_user_policy" "glue_policy" {
  name = "glue-service-policy"
  user = aws_iam_user.glue_user.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "glue:*",
          "logs:*",
          "s3:GetObject",
          "s3:PutObject"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_access_key" "glue_key" {
  user = aws_iam_user.glue_user.name
}

# --- Athena User ---
resource "aws_iam_user" "athena_user" {
  name = "service-user-athena"
}

resource "aws_iam_user_policy" "athena_policy" {
  name = "athena-service-policy"
  user = aws_iam_user.athena_user.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "athena:*",
          "s3:GetObject",
          "s3:PutObject"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_access_key" "athena_key" {
  user = aws_iam_user.athena_user.name
}

# --- Redshift User ---
resource "aws_iam_user" "redshift_user" {
  name = "service-user-redshift"
}

resource "aws_iam_user_policy" "redshift_policy" {
  name = "redshift-service-policy"
  user = aws_iam_user.redshift_user.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "redshift:*",
          "logs:*"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_access_key" "redshift_key" {
  user = aws_iam_user.redshift_user.name
}
