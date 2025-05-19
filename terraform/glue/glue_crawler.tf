resource "aws_glue_catalog_database" "reddit_database" {
  name = "reddit-db"
  description = "Glue Database for Reddit pipeline"
}

resource "aws_glue_crawler" "reddit_crawler" {
  name          = "reddit-crawler"
  role          = aws_iam_role.glue_job_role.arn
  database_name = aws_glue_catalog_database.reddit_database.name

  s3_target {
    path = "s3://reddit-pipeline-bckt/transformed/"
  }

  schema_change_policy {
    delete_behavior = "LOG"
    update_behavior = "UPDATE_IN_DATABASE"
  }
}
