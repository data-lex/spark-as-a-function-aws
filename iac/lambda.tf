resource "aws_lambda_function" "sparkf_deployer" {
  filename         = "deployer.zip"
  function_name    = "sparkf-deployer-beta"
  role             = aws_iam_role.deployer.arn
  handler          = "main.handler"
  source_code_hash = filebase64sha256("deployer.zip")
  runtime          = "python3.9"
  timeout          = 30
}

resource "aws_lambda_function" "sparkf_watcher" {
  filename         = "watcher.zip"
  function_name    = "sparkf-watcher-beta"
  role             = aws_iam_role.watcher.arn
  handler          = "main.handler"
  source_code_hash = filebase64sha256("watcher.zip")
  runtime          = "python3.9"
  timeout          = 10 
}

resource "aws_lambda_function_url" "deployer_url" {
  function_name      = aws_lambda_function.sparkf_deployer.function_name
  authorization_type = "AWS_IAM"
  cors {
    allow_origins = ["*"]
    allow_methods = ["POST"]
  }
}

resource "aws_lambda_function_url" "watcher_url" {
  function_name      = aws_lambda_function.sparkf_watcher.function_name
  authorization_type = "AWS_IAM"
  cors {
    allow_origins = ["*"]
    allow_methods = ["POST"]
  }
}
