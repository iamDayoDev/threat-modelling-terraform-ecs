module "ecr" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "2.3.0"

  repository_name    = var.ecr_repo_name
  registry_scan_type = "BASIC"
  repository_type    = "private"

  create_registry_policy = false

  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire untagged images older than 14 days"
        selection = {
          tagStatus     = "untagged"
          countType     = "sinceImagePushed"
          countUnit     = "days"
          countNumber   = 14
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
  tags = {
    Terraform = "true"
  }
}