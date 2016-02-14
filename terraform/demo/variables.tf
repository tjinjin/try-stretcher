# common settings
variable "region" {
  default = "ap-northeast-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  default = {
    "0" = "10.0.1.0/24"
    "1" = "10.0.2.0/24"
  }
}

variable "private_subnets" {
  default = {
    "0" = "10.0.16.0/24"
    "1" = "10.0.17.0/24"
  }
}

variable "availability_zones" {
  default = {
    "0" = "ap-northeast-1a"
    "1" = "ap-northeast-1c"
  }
}

variable "az_count" {
  default = "2"
}

variable "bastion_ami" {
  default = "ami-b80b6db8"
}

variable "bastion_instance_type" {
  default = "t2.micro"
}

variable "key_name" {}

variable "project_name" {}

##
#
## blue-green
variable "blue_ami" {
  default = "ami-b80b6db8"
}
variable "green_ami" {
  default = "ami-b80b6db8"
}
variable "blue_instance_type" {
  default = "t2.micro"
}
variable "green_instance_type" {
  default = "t2.micro"
}
variable "blue_instances" {
  default = "0"
}
variable "green_instances" {
  default = "0"
}
