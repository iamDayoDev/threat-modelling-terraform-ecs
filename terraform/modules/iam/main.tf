resource "aws_iam_role" "this" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Principal = {
        Service = var.assume_service
      },
      Effect = "Allow",
      Sid    = ""
    }]
  })
}

resource "aws_iam_role_policy" "this" {
  name = var.policy_name
  role = aws_iam_role.this.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:CreateLogGroup"
        ],
        Resource = [
          format("arn:aws:logs:%s:%s:*", var.region, var.account_id)
        ]
      },
      {
        Effect = "Allow"
        Principal = {
          Service = "logdelivery.elasticloadbalancing.amazonaws.com"
        }
        Action = [
          "s3:PutObject"
        ]
        Resource = "arn:aws:s3:::access-logs-threat-modelling-app/AWSLogs/*"

      },

      {
        Effect = "Allow",
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage"
        ],
        Resource = [
          format("arn:aws:ecr:%s:%s:repository/%s", var.region, var.account_id, var.ecr_repo_name)
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "ecr:GetAuthorizationToken"
        ],
        Resource = "*"
      }
    ]
  })
}

# IAM Policy for OIDC GitHub Actions
resource "aws_iam_policy" "github_actions_ecs_policy" {
  name        = "GitHubActionsECSPolicy"
  description = "Policy for GitHub Actions to access ECS and ECR"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecs:DescribeCluster",
          "ecs:ListClusters"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:PutImage"
        ]
        Resource = "*"
      }
    ]
  })

  tags = {
    Name = "GitHub-Actions-ECS-Policy"
  }
}

# # IAM Role
# resource "aws_iam_role" "github_actions_ecs_deploy_role" {
#   name = "GitHubActionsECSDeployRole"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Principal = {
#           Federated = var.github_oidc_provider_arn

#         }
#         Action = "sts:AssumeRoleWithWebIdentity"
#         Condition = {
#           StringLike = {
#             "token.actions.githubusercontent.com:sub" = [
#               for repo in var.github_repositories : 
#                 "repo:${repo.org}/${repo.repo}:${repo.branch}"
#             ]
#           }
#         }
#       }
#     ]
#   })

#   tags = {
#     Name = "GitHub-Actions-ECS-Deploy-Role"
#   }
# }

# # Policy Attachment
# resource "aws_iam_role_policy_attachment" "github_actions_ecs_policy_attachment" {
#   role       = aws_iam_role.github_actions_ecs_deploy_role.name
#   policy_arn = aws_iam_policy.github_actions_ecs_policy.arn
# }
