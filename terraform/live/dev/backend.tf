terraform {
  backend "s3" {
    bucket         = "foodbyte-tf-state-fdc22cc6"
    key            = "dev/infrastructure.tfstate"
    region         = "us-east-1"
    use_lockfile   = true
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.42.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  
  default_tags {
    tags = {
      Environment = "dev"
      Project     = "FoodByte"
      ManagedBy   = "Terraform"
    }
  }
}
