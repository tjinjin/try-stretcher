resource "aws_elb" "blue" {
    name = "blue-load-balancer"
    subnets = ["${aws_subnet.private.*.id}"]
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
