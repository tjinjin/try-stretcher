resource "aws_vpc" "demo" {
    cidr_block = "${var.vpc_cidr}"
    tags {
        Name = "demo"
        Created = "terraform"
    }
}

resource "aws_subnet" "public" {
    vpc_id = "${aws_vpc.demo.id}"
    count = "${var.az_count}"
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
    count = "${var.az_count}"
    cidr_block = "${lookup(var.private_subnets, count.index)}"
    availability_zone = "${lookup(var.availability_zones, count.index)}"
    map_public_ip_on_launch = false
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

resource "aws_route_table" "public" {
    vpc_id = "${aws_vpc.demo.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.demo.id}"
    }
}

resource "aws_route_table_association" "public" {
    count = "${var.az_count}"
    subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
    route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table" "private" {
    vpc_id = "${aws_vpc.demo.id}"
    route {
        cidr_block = "0.0.0.0/0"
#        nat_gateway_id = "${aws_nat_gateway.demo.id}"
        instance_id = "${aws_instance.nat.id}"
    }
}

resource "aws_route_table_association" "private" {
    count = "${var.az_count}"
    subnet_id = "${element(aws_subnet.private.*.id, count.index)}"
    route_table_id = "${aws_route_table.private.id}"
}
