output "ecr_repo_url" {
  description = "URL of the ECR repository"
  value       = module.ecr.repository_url
}