variable "role_name" {
  description = "IAM role name"
  type        = string
}

variable "assume_service" {
  type = string
}

variable "policy_name" {
  type = string
}
variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "ecr_repo_name" {
  description = "Name of the ECR repository"
  type        = string
}
variable "account_id" {
  description = "AWS account ID"
  type        = string
}

# variable "github_repositories" {
#   description = "List of GitHub repositories to grant access to"
#   type = list(object({
#     org    = string
#     repo   = string
#     branch = optional(string, "*")
#   }))
# }

# variable "github_oidc_provider_arn" {
#   type        = string
#   description = "ARN of the GitHub OIDC provider"
# }

