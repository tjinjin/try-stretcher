variable "instance_type" {
  default = "t2.micro"
}
variable "ami" {
  default = "ami-b80b6db8"
}
variable "blue_instances" {
  default = "0"
}
variable "green_instances" {
  default = "0"
}
variable "azs" {
  default = {
    "0" = "ap-northeast-1a"
    "1" = "ap-northeast-1c"
  }
}
variable "region" {
  default = "ap-northeast-1"
}
variable "vpc_cidr" {
  default = "10.89.0.0/16"
}
variable "subnets" {
  default = {
    "0" = "10.89.10.0/24"
    "1" = "10.89.11.0/24"
    "2" = "10.89.12.0/24"
  }
}
