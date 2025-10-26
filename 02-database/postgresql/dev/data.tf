
data "aws_ssm_parameter" "username" {
  name = "/${var.project}/${var.environment}/postgres/user/admin_username"
}

data "aws_ssm_parameter" "password" {
  name = "/${var.project}/${var.environment}/postgres/user/admin_password"
}

# data "aws_ssm_parameter" "zone_id" {
#   name = "/${var.project}/${var.environment}/zone_id"
# }


data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project}/dev/vpc_id"
}

data "aws_ssm_parameter" "database_subnets" {
  name = "/${var.project}/dev/database_subnets"
}
