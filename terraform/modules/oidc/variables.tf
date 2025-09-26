# # Variables
# variable "aws_region" {
#   description = "AWS region"
#   type        = string
#   default     = "us-east-1"
# }

# variable "github_repositories" {
#   description = "List of GitHub repositories to grant access to"
#   type = list(object({
#     org    = string
#     repo   = string
#     branch = optional(string, "*")
#   }))
#   default = [
#     {
#       org    = "iamDayoDev"
#       repo   = "threat-modelling-terraform-ecs"
#       branch = "*"
#     }
#   ]
# }