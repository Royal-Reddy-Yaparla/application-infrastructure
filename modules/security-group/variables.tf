variable "sg_name" {
  type = string
}

variable "sg_description" {
  type = string
}

variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "use_default_vpc" {
  type = bool
  default = false
}
variable "vpc_id" {
  type = string
  default = ""
}

variable "sg_tags" {
  type    = map(any)
  default = {

  }
}


