resource "aws_ecs_cluster" "sparkf_cluster" {
  depends_on = [
    aws_cloudwatch_log_group.sparkf_api,
    aws_cloudwatch_log_group.sparkf_task
  ]
  name = "sparkf_test"
}

resource "aws_ecs_task_definition" "sparkf_tiny" {
  family                   = "sparkf_tiny_test"
  execution_role_arn       = aws_iam_role.ecs_task_exec.arn
  task_role_arn            = aws_iam_role.sparkf_task.arn
  
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 2048
  memory                   = 4096
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "sparkf",
    "image": "199871617185.dkr.ecr.us-east-1.amazonaws.com/sparkf:latest",
    "essential": true,
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/sparkf/task",
        "awslogs-region": "us-east-1",
        "awslogs-stream-prefix": "tiny"
      }
    }
  }
]
TASK_DEFINITION

  runtime_platform {
    operating_system_family = "LINUX"
  }
}

resource "aws_ecs_task_definition" "sparkf_small" {
  family                   = "sparkf_small_test"
  execution_role_arn       = aws_iam_role.ecs_task_exec.arn
  task_role_arn            = aws_iam_role.sparkf_task.arn
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 4096
  memory                   = 8192
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "sparkf",
    "image": "199871617185.dkr.ecr.us-east-1.amazonaws.com/sparkf:latest",
    "essential": true,
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/sparkf/task",
        "awslogs-region": "us-east-1",
        "awslogs-stream-prefix": "small"
      }
    }
  }
]
TASK_DEFINITION

  runtime_platform {
    operating_system_family = "LINUX"
  }
}

resource "aws_ecs_task_definition" "sparkf_medium" {
  family                   = "sparkf_medium_test"
  execution_role_arn       = aws_iam_role.ecs_task_exec.arn
  task_role_arn            = aws_iam_role.sparkf_task.arn
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 4096
  memory                   = 16384
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "sparkf",
    "image": "199871617185.dkr.ecr.us-east-1.amazonaws.com/sparkf:latest",
    "essential": true,
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/sparkf/task",
        "awslogs-region": "us-east-1",
        "awslogs-stream-prefix": "medium"
      }
    }
  }
]
TASK_DEFINITION

  runtime_platform {
    operating_system_family = "LINUX"
  }
}

resource "aws_ecs_task_definition" "sparkf_large" {
  family                   = "sparkf_large_test"
  execution_role_arn       = aws_iam_role.ecs_task_exec.arn
  task_role_arn            = aws_iam_role.sparkf_task.arn
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 4096
  memory                   = 24576
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "sparkf",
    "image": "199871617185.dkr.ecr.us-east-1.amazonaws.com/sparkf:latest",
    "essential": true,
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/sparkf/task",
        "awslogs-region": "us-east-1",
        "awslogs-stream-prefix": "large"
      }
    }
  }
]
TASK_DEFINITION

  runtime_platform {
    operating_system_family = "LINUX"
  }
}

resource "aws_ecs_task_definition" "sparkf_xlarge" {
  family                   = "sparkf_xlarge_test"
  execution_role_arn       = aws_iam_role.ecs_task_exec.arn
  task_role_arn            = aws_iam_role.sparkf_task.arn
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 4096
  memory                   = 30720
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "sparkf",
    "image": "199871617185.dkr.ecr.us-east-1.amazonaws.com/sparkf:latest",
    "essential": true,
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/sparkf/task",
        "awslogs-region": "us-east-1",
        "awslogs-stream-prefix": "xlarge"
      }
    }
  }
]
TASK_DEFINITION

  runtime_platform {
    operating_system_family = "LINUX"
  }
}

