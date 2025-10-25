resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.project}/${local.environment[terraform.workspace]}/vpc_id"
  type  = "String"
  value = module.vpc.vpc_id
}

resource "aws_ssm_parameter" "public_subnets" {
  name  = "/${var.project}/${local.environment[terraform.workspace]}/public_subnets"
  type  = "StringList"
  value = join(",", module.vpc.public_subnets)
}

resource "aws_ssm_parameter" "private_subnets" {
  name  = "/${var.project}/${local.environment[terraform.workspace]}/private_subnets"
  type  = "StringList"
  value = join(",", module.vpc.private_subnets)
}

resource "aws_ssm_parameter" "database_subnets" {
  name  = "/${var.project}/${local.environment[terraform.workspace]}/database_subnets"
  type  = "StringList"
  value = join(",", module.vpc.database_subnets)
}
