variable "aws_region" {
  description = "Região da AWS"
  type        = string
  default     = "sa-east-1"
}

variable "bucket_name" {
  description = "Nome único do bucket S3"
  type        = string
}