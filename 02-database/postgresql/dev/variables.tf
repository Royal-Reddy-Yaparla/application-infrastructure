variable "project" {
  default = "my-project"
}

variable "description" {
  default = ""
}

variable "environment" {
  default = "dev"
}

variable "name" {
  default = "user"
}

variable "instance_class" {
  type = string
  default = "db.t3.small"
}

variable "rds_tags" {
  default = {
    component  = "db",
    created    = "royal-1158",
    maintained = "devops-team"
  }
}

variable "sg_tags" {
  default = {
    component  = "database",
    created    = "royal-1158",
    maintained = "devops-team"
  }
}

variable "backend_ports" {
  default = [5432]
}

# prefer to take ssm parameter, for testing 
variable "username" {
  sensitive = true
  default   = ""
}

variable "password" {
  sensitive = true
  default   = ""
}

variable "domain" {
  default = "surnoi.in"
}