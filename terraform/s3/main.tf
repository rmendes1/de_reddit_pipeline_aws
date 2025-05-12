provider "aws" {
  profile = "terraform-user"
  region  = var.aws_region
}

resource "aws_s3_bucket" "pipeline_bucket" {
  bucket        = var.bucket_name
  force_destroy = false
}
