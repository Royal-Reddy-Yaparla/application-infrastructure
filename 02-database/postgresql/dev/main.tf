resource "aws_security_group" "user_db" {
  name        = "${var.project}-${var.environment}-user_db"
  description = "allowing 5432"
  vpc_id      = data.aws_ssm_parameter.vpc_id.value
  tags = merge(
    local.common_tags,
    var.sg_tags,
    {
      Name = "${var.project}-${var.environment}-user_db"
    }
  )
}
resource "aws_security_group_rule" "user_db_ingress_rules" {
  count       = length(var.backend_ports)
  type        = "ingress"
  from_port   = var.backend_ports[count.index]
  to_port     = var.backend_ports[count.index]
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  # source_security_group_id = 
  security_group_id = aws_security_group.user_db.id
}

resource "aws_security_group_rule" "bastion_sg_egress_rules" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.user_db.id
}

resource "aws_db_subnet_group" "user" {
  name       = "${var.project}-${var.environment}-postgres-subnet-group"
  subnet_ids = split(",",data.aws_ssm_parameter.database_subnets.value)# change vpc subnets

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-${var.name}"
    }
  )
}


resource "aws_db_parameter_group" "postgres_custom" {
  name        = "logistics-custom-postgres-params"
  family      = "postgres15"
  description = "Custom PostgreSQL parameters for Logistics"

  # Session and transaction safety
  parameter {
    name         = "idle_in_transaction_session_timeout"
    value        = "600000"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "statement_timeout"
    value        = "600000"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "max_connections"
    value        = "300"
    apply_method = "pending-reboot"
  }

  # Logs all statements (you can change to 'ddl' if logs are too big)
  parameter {
    name         = "log_statement"
    value        = "all"
    apply_method = "pending-reboot"
  }

  # Log queries slower than 2 seconds
  parameter {
    name         = "log_min_duration_statement"
    value        = "2000"
    apply_method = "pending-reboot"
  }

  # Log connections & disconnections (track user login/logout)
  parameter {
    name         = "log_connections"
    value        = "1"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "log_disconnections"
    value        = "1"
    apply_method = "pending-reboot"
  }

  # Log checkpoints and autovacuum
  parameter {
    name         = "log_checkpoints"
    value        = "1"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "log_autovacuum_min_duration"
    value        = "0"
    apply_method = "pending-reboot"
  }

  # Log lock waits (helps track blocking queries by users)
  parameter {
    name         = "log_lock_waits"
    value        = "1"
    apply_method = "pending-reboot"
  }

  # Add user info in logs
  parameter {
    name         = "log_line_prefix"
    value        = "%t:%r:%u@%d:[%p]:"
    apply_method = "pending-reboot"
  }
}


resource "aws_db_instance" "default" {
  allocated_storage       = 20
  identifier              = "${var.project}-${var.environment}-${var.name}"
  engine                  = "postgres"
  engine_version          = "15.13"
  instance_class          = var.instance_class
  apply_immediately       = false # make sure , effect immediately or not 
  db_subnet_group_name    = aws_db_subnet_group.user.name
  username                = data.aws_ssm_parameter.username.value
  password                = data.aws_ssm_parameter.password.value
  parameter_group_name    = aws_db_parameter_group.postgres_custom.name
  skip_final_snapshot     = true
  vpc_security_group_ids  = [aws_security_group.user_db.id]
  publicly_accessible     = false
  performance_insights_enabled = true
  backup_retention_period = 1 # everyday 
  tags = merge(
    var.rds_tags,
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-${var.name}"
    }
  )
}

# resource "aws_route53_record" "postgres" {
#   zone_id = data.aws_ssm_parameter.zone_id.value
#   name    = "write-${var.project}.${var.domain}"
#   type    = "CNAME"
#   ttl     = 1
#   records = [aws_db_instance.default.address]
# }