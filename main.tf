terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.53.0"
    }
  }
  backend "s3" {
    bucket = "devops-create-image-nest-iac-terraform-state"
    key    = "state/terraform.tfstate"
    region = "us-east-2"
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "terraform_state" {
  bucket        = "devops-create-image-nest-iac-terraform-state"
  force_destroy = true

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    IaC = "True"
  }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = "devops-create-image-nest-iac-terraform-state"

  versioning_configuration {
    status = "Enabled"
  }
}