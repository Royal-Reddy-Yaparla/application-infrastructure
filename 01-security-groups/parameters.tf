resource "aws_ssm_parameter" "user_db_sg_id" {
  name  = "/${var.project}/${var.environment}/user_db_sg_id"
  type  = "String"
  value = module.user_db.sg_id
}

