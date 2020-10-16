terraform {
  required_version = "~> 0.13.0"
}

# authenticated with shared credentials "$HOME/.aws/credentials"
provider "aws" {
  region = var.aws_region
}