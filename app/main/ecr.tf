resource "aws_ecr_repository" "app" {
  name   = "${local.system_name}-app"

  tags = {
      Name = "${local.system_name}-app"
  }
}

# 
resource "aws_ecr_lifecycle_policy" "app" {
  policy = jsonencode(
    {
      "rules" : [
        {
          "rulePriority" : 1,
          "description" : "Hold only 10 images, expire all others",
          "selection" : {
            "tagStatus" : "any",
            "countType" : "imageCountMoreThan",
            "countNumber" : 10
          },
          "action" : {
            "type" : "expire"
          }
      }]
  })

  repository =  aws_ecr_repository.app.name
}