variable "vpc_id" {
  default = ""
}

variable "project" {
  default = "myproject"
}

variable "environment" {
  default = "dev"
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