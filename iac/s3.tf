resource "aws_s3_bucket" "sparkf_bucket" {
  bucket = "sparkf.output"
}

resource "aws_s3_bucket_lifecycle_configuration" "bucket_settings" {
  bucket = aws_s3_bucket.sparkf_bucket.id
  rule {
    id = "Cleanup"
    expiration {
      days = "5"
    }
  }
}

resource "aws_s3_object" "upload_runner" {
  key    = "ecs/sparkf/runner.jar"
  bucket = "aws.settings"
  source = "runner.jar"
}
