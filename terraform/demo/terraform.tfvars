## common
region = "ap-northeast-1"

key_name = "tjinjin-terraform"

project_name = "try-stretcher"

bastion_ami = "ami-ee5a5b80"

## green settings
green_ami = "ami-2c5b5a42"
green_instance_type = "t2.micro"

## blue settings
blue_ami    = "ami-2c5b5a42"
blue_instance_type = "t2.micro"

## blue-green
blue_instances  = "2"
green_instances = "2"
