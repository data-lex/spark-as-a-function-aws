data "aws_iam_policy_document" "ecr_policy" {
  statement {
    actions = [
      "ecr:GetAuthorizationToken",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }

  statement {
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage"
    ]
    resources = ["*"]
    condition {
      test     = "StringLike"
      variable = "aws:sourceVpc"
      values   = ["vpc-2724385d"]
    }
  }
}


resource "aws_iam_role" "ecs_task_exec" {
  name               = "ecsTaskExecutionRole"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  inline_policy {
    name   = "ecrVpcEndpointPolicy"
    policy = data.aws_iam_policy_document.ecr_policy.json
  }

  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]
}


resource "aws_iam_role" "sparkf_task" {
  name               = "sparkfTaskRole"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  inline_policy {
    name = "sparkfTaskPolicy"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Effect = "Allow"
          Action = [
            "s3:*",
            "s3-object-lambda:*"
          ]
          Resource = "arn:aws:s3:::sparkf.output/*"
        },
        {
          Effect = "Allow"
          Action = "logs:PutLogEvents"
          Resource = [
            "arn:aws:logs:us-east-1:199871617185:log-group:/sparkf/api:log-stream:*",
            "arn:aws:logs:us-east-1:199871617185:log-group:/sparkf/api"
          ]
        }
      ]
    })
  }

  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"]
}
