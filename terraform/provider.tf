#  Terraform block - Used to configure terraform itself
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "my-terraform-threat-modelling-bucket"
    key            = "state/devops-lab/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "threat-modelling-terraform-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}

