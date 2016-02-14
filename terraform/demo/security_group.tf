resource "aws_security_group" "bastion" {
    name = "bastion"
    description = "bastion sg"
    vpc_id = "${aws_vpc.demo.id}"
    ingress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

      tags {
          Name = "demo"
          Created = "terraform"
      }
}

resource "aws_security_group" "private_instances" {
    name = "private_instances"
    description = "belong to private ec2 instances"
    vpc_id = "${aws_vpc.demo.id}"

   ingress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }

    # for consul
    ingress {
        from_port = 8301
        to_port = 8302
        protocol = "udp"
        cidr_blocks = ["10.0.0.0/16"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags {
        Name = "demo"
        Created = "terraform"
    }
}

resource "aws_security_group" "elb" {
    name = "allow http/https"
    description = "Used in the terraform"
    vpc_id = "${aws_vpc.demo.id}"
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
    tags {
        Name = "demo"
        Created = "terraform"
    }
}
