resource "aws_cloudwatch_log_group" "sparkf_api" {
  name = "/sparkf/api"
  retention_in_days = 5
}

resource "aws_cloudwatch_log_group" "sparkf_task" {
  name = "/sparkf/task"
  retention_in_days = 5
}
