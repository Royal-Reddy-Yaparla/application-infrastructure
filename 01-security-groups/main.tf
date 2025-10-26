module "user_db" {
  source         = "../../modules/security-group"
  vpc_id         = data.aws_ssm_parameter.vpc_id
  sg_name        = "${var.project}-${var.environment}-${var.name}"
  sg_description = var.description
  project        = var.project
  environment    = var.environment
  sg_tags        = "${var.project}-${var.environment}-${var.name}"
}

resource "aws_security_group_rule" "main_ingress_rules" {
  count             = length(var.backend_ports)
  type              = "ingress"
  from_port         = var.backend_ports[count.index]
  to_port           = var.backend_ports[count.index]
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.user-db.sg_id
}

resource "aws_security_group_rule" "main_all_traffic_ingress_rules" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.user-db.sg_id
}
