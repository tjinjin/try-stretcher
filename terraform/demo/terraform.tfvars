## common
region = "ap-northeast-1"

key_name = "tjinjin-terraform"

project_name = "try-stretcher"

bastion_ami = "ami-b7c4cdd9"

## green settings
green_ami = "ami-b7c4cdd9"
green_instance_type = "t2.micro"

## blue settings
blue_ami    = "ami-b7c4cdd9"
blue_instance_type = "t2.micro"

## blue-green
blue_instances  = "2"
green_instances = "0"
