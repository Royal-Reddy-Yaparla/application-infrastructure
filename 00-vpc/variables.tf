variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "project" {
  default = "logistics-mot"
}

variable "environment" {
  default = "dev"
}

variable "vpc_tags" {
  default = {
    region  = "us-east-1"
    created = "devops"
  }
}

variable "public_cidr_block" {
  type    = list(any)
  default = ["10.0.0.0/20", "10.0.16.0/20"]
}

variable "private_cidr_block" {
  type    = list(any)
  default = ["10.0.32.0/20", "10.0.48.0/20"]
}

variable "database_cidr_block" {
  type    = list(any)
  default = ["10.0.64.0/20", "10.0.80.0/20"]
}

variable "is_peering_required" {
  type    = bool
  default = false
}