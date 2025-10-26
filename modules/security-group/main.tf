resource "aws_security_group" "this" {
  name        = "${var.project}-${var.environment}-${var.sg_name}"
  description = var.sg_description
  vpc_id      = var.vpc_id == "" ? data.aws_vpc.main.id : var.vpc_id
  tags = merge(
    local.common_tags,
    var.sg_tags,
    {
      Name = "${var.project}-${var.environment}-${var.sg_name}"
    }
  )
}

resource "aws_security_group_rule" "bastion_sg_egress_rules" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this.id
}
