## common settings
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
