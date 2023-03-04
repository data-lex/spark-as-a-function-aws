resource "aws_iam_role" "deployer" {
  depends_on = [
    aws_iam_role.ecs_task_exec,
    aws_iam_role.sparkf_task
  ]
  name               = "sparkfDeployerRole"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  inline_policy {
    name = "sparkfDeployerPassRolePolicy"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Effect   = "Allow"
          Action   = ["ecs:RunTask"]
          Resource = "*"
        },
        {
          Effect = "Allow"
          Action = "iam:PassRole"
          Resource = [
            "arn:aws:iam::199871617185:role/ecsTaskExecutionRole",
            "arn:aws:iam::199871617185:role/sparkfTaskRole"
          ]
        }
      ]
    })
  }

  inline_policy {
    name = "sparkfDeployerPolicy"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Effect = "Allow"
          Action = [
            "lambda:InvokeFunction",
            "lambda:InvokeFunctionUrl"
          ]
          Resource = "*"
        },
        {
          Effect = "Allow"
          Action = [
            "logs:CreateLogStream",
            "logs:PutLogEvents"
          ]
          Resource = [
            "arn:aws:logs:us-east-1:199871617185:log-group:/sparkf/api",
            "arn:aws:logs:us-east-1:199871617185:log-group:/sparkf/api:log-stream:*"
          ]
        }
      ]
    })
  }

  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"]
}


resource "aws_iam_role" "watcher" {
  name               = "sparkfWatcherRole"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  inline_policy {
    name = "sparkfWatcherPolicy"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Effect = "Allow"
          Action = [
            "lambda:InvokeFunction",
            "lambda:InvokeFunctionUrl"
          ]
          Resource = "*"
        },
        {
          Effect = "Allow"
          Action = [
            "logs:Describe*",
            "logs:FilterLogEvents",
            "logs:Get*",
            "logs:List*",
            "logs:StartQuery",
            "logs:StopQuery",
            "logs:TestMetricFilter"
          ]
          Resource = [
            "arn:aws:logs:us-east-1:199871617185:log-group:/sparkf/api:log-stream:*",
            "arn:aws:logs:us-east-1:199871617185:log-group:/sparkf/api"
          ]
        }
      ]
    })
  }
}
