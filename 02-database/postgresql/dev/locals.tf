locals {
  environment = {
    dev  = "dev"
    qa   = "qa"
    prod = "prod"
  }
  common_tags = {
    Project     = var.project
    Environment = var.environment
    Terraform   = true
  }
}