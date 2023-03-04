resource "aws_ecr_repository" "sparkf" {
  name                 = "sparkf"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
