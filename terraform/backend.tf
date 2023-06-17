terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.58"
    }
  }
  required_version = ">= 1.3.7"
}

provider "aws" {}

locals {
  tags = {
    app               = "ping-pong"
    stage             = "alpha"
    terraform-managed = true
  }
}
