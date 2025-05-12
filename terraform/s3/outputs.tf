output "bucket_name" {
  description = "Nome do bucket S3"
  value       = aws_s3_bucket.pipeline_bucket.bucket
}

output "bucket_arn" {
  description = "ARN do bucket S3"
  value       = aws_s3_bucket.pipeline_bucket.arn
}
