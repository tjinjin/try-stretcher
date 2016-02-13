resource "aws_vpc" "demo" {
    cidr_block = "${var.vpc_cidr}"
    tags {
        Name = "demo"
        Created = "terraform"
    }
}

resource "aws_subnet" "public" {
    vpc_id = "${aws_vpc.demo.id}"
    count = 2
    cidr_block = "${lookup(var.public_subnets, count.index)}"
    availability_zone = "${lookup(var.availability_zones, count.index)}"
    map_public_ip_on_launch = true
    tags {
        Name = "demo"
        Created = "terraform"
    }
}

resource "aws_subnet" "private" {
    vpc_id = "${aws_vpc.demo.id}"
    count = 2
    cidr_block = "${lookup(var.private_subnets, count.index)}"
    availability_zone = "${lookup(var.availability_zones, count.index)}"
    map_public_ip_on_launch = true
    tags {
        Name = "demo"
        Created = "terraform"
    }
}

resource "aws_internet_gateway" "demo" {
    vpc_id = "${aws_vpc.demo.id}"
    tags {
        Name = "demo"
        Created = "terraform"
    }
}
