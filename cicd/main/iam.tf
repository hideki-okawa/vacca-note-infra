resource "aws_iam_user" "github" {
  name = "${local.system_name}-github"

  tags = {
    Name = "${local.system_name}-github"
  }
}

resource "aws_iam_role" "deployer" {
  name = "${local.system_name}-deployer"

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "sts:AssumeRole",
            "sts:TagSession"
          ],
          "Principal" : {
            "AWS" : aws_iam_user.github.arn # example-prod-foobar-github のIAMユーザーからAssumeRoleが許可
          }
        }
      ]
    }
  )

  tags = {
    Name = "${local.system_name}-deployer"
  }
}

resource "aws_iam_role_policy_attachment" "role_deployer_ecr_power_user" {
  role       = aws_iam_role.deployer.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

resource "aws_iam_role_policy" "s3" {
  name = "s3"
  role = aws_iam_role.deployer.id

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "s3:GetObject",
            "s3:PutObject"
          ],
          "Resource" : [
              "arn:aws:s3:::okawa-tfstate/${local.system_name}/cicd/main.tfstate",
              "arn:aws:s3:::vacca-note-view/*"
          ]
        },
      ]
    }
  )
}

resource "aws_iam_role_policy" "cloudfront" {
  name = "cloudfront"
  role = aws_iam_role.deployer.id

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
            "Effect": "Allow",
            "Action": [
               "cloudfront:ListDistributions",
               "cloudfront:CreateInvalidation",
            ]
            "Resource": "*"
        },
      ]
    }
  )
}

resource "aws_iam_role_policy" "ecs" {
  name = "ecs"
  role = aws_iam_role.deployer.id

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "RegisterTaskDefinition",
          "Effect" : "Allow",
          "Action" : [
            "ecs:RegisterTaskDefinition"
          ],
          "Resource" : "*"
        },
        {
          "Sid" : "PassRolesInTaskDefinition",
          "Effect" : "Allow",
          "Action" : [
            "iam:PassRole"
          ],
          "Resource" : [
            data.aws_iam_role.ecs_task.arn,
            data.aws_iam_role.ecs_task_execution.arn,
          ]
        },
        {
          "Sid" : "DeployService",
          "Effect" : "Allow",
          "Action" : [
            "ecs:UpdateService",
            "ecs:DescribeServices"
          ],
          "Resource" : [
            data.aws_ecs_service.this.arn
          ]
        }
      ]
    }
  )
}