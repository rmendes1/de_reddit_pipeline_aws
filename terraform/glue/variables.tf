variable "aws_region" {
  description = "Região AWS"
  type        = string
  default     = "sa-east-1"
}

variable "glue_job_name" {
  description = "Nome do Glue Job"
  type        = string
}

variable "input_path" {
  description = "Caminho do S3 para os dados de entrada"
  type        = string
}

variable "output_path" {
  description = "Caminho do S3 para os dados de saída"
  type        = string
}

variable "script_location" {
  description = "Localização do script Glue no S3"
  type        = string
}

variable "temp_dir" {
  description = "Path do diretorio temporário no S3"
  type        = string
}

variable "s3_bucket" {
  description = "Nome único do bucket S3"
  type        = string
}