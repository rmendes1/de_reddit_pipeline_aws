resource "aws_glue_job" "reddit_job" {
  name     = var.glue_job_name
  role_arn = aws_iam_role.glue_job_role.arn

  command {
    name            = "glueetl"
    script_location = var.script_location
    python_version  = "3"
  }

  default_arguments = {
    "--JOB_NAME"     = var.glue_job_name
    "--INPUT_PATH"   = var.input_path
    "--OUTPUT_PATH"  = var.output_path
    "--TempDir"      = var.temp_dir
    "--enable-metrics" = "true"
    "--job-language"   = "python"
  }

  glue_version      = "4.0"
  number_of_workers = 2
  worker_type       = "G.1X"
  description       = "Reddit Job"
}

resource "aws_glue_trigger" "reddit-job-trigger" {
  name     = "reddit-daily-trigger"
  type     = "SCHEDULED"
  schedule = "cron(0 3 * * ? *)"

  actions {
    job_name = aws_glue_job.reddit_job.name
  }
}
