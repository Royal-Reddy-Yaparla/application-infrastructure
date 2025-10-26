module "vpc" {
  source              = "../modules/vpc"
  environment         = local.environment[terraform.workspace]
  project             = var.project
  vpc_cidr_block      = local.cidr_block[terraform.workspace]
  public_cidr_block   = local.public_cidr_block[terraform.workspace]
  private_cidr_block  = local.private_cidr_block[terraform.workspace]
  database_cidr_block = local.database_cidr_block[terraform.workspace]
  is_peering_required = var.is_peering_required
}
