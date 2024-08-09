terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.62.0"
    }
  }

  required_version = ">= 1.9.2"
}

provider "aws" {
  region = var.aws_region
}
