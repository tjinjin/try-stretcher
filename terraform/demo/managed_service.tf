resource "aws_nat_gateway" "demo" {
    allocation_id = "${aws_eip.nat_gateway.id}"
    subnet_id = "${aws_subnet.public.0.id}"
}

resource "aws_eip" "nat_gateway" {
    vpc = true
}

resource "aws_elb" "blue" {
    name = "blue-load-balancer"
    subnets = ["${aws_subnet.public.*.id}"]
    security_groups = ["${aws_security_group.elb.id}"]
    cross_zone_load_balancing = true
    listener {
        instance_port = 80
        instance_protocol = "http"
        lb_port = 80
        lb_protocol = "http"
    }
    health_check {
        healthy_threshold = 2
        unhealthy_threshold = 2
        timeout = 2
        target = "HTTP:80/"
        interval = 5
    }
    tags {
        Name = "demo"
        Created = "terraform"
    }
}

resource "aws_elb" "green" {
    name = "green-load-balancer"
    subnets = ["${aws_subnet.public.*.id}"]
    security_groups = ["${aws_security_group.elb.id}"]
    cross_zone_load_balancing = true
    listener {
        instance_port = 80
        instance_protocol = "http"
        lb_port = 80
        lb_protocol = "http"
    }
    health_check {
        healthy_threshold = 2
        unhealthy_threshold = 2
        timeout = 2
        target = "HTTP:80/"
        interval = 5
    }
    tags {
        Name = "demo"
        Created = "terraform"
    }
}
