output "github_actions_ecs_deploy_role_arn" {
  description = "ARN of the GitHub Actions ECS Deploy Role"
  value       = aws_iam_role.github_actions_ecs_deploy_role.arn
}
output "github_oidc_provider_arn" {
  value = aws_iam_openid_connect_provider.github_actions.arn
}
