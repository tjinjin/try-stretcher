resource "aws_instance" "test" {
    ami = "ami-b80b6db8"
    instance_type = "t2.micro"
    key_name = "${var.key_name}"

    # Our Security group to allow HTTP and SSH access
    security_groups = ["${aws_security_group.test.name}"]

    root_block_device {
        delete_on_termination = "true"
        volume_size = "8"
    }
    tags {
        Name = "test"
        Project = "test"
    }
}

resource "aws_security_group" "test" {
    name = "test"
    description = "Used in the terraform"

    # SSH access from anywhere
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
}

resource "aws_security_group" "add-test" {
    name = "add-test"
    description = "Used in the terraform"

    # SSH access from anywhere
    ingress {
        from_port = 21
        to_port = 21
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
