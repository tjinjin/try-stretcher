resource "aws_elb" "example" {
  name = "terraform-asg-deployment-example"
  subnets = ["${aws_subnet.example.*.id}"]
  security_groups = ["${aws_security_group.example.id}"]
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
}

resource "aws_launch_configuration" "blue" {
  image_id = "${var.ami}"
  name_prefix = "blue-"
  instance_type = "${var.instance_type}"
  key_name = "tjinjin-terraform"
  security_groups = ["${aws_security_group.example.id}"]
  user_data = "${file("./boot-blue.sh")}"

  root_block_device {
    delete_on_termination = "false"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "blue" {
  name = "blue"
  launch_configuration = "${aws_launch_configuration.blue.id}"
  availability_zones = ["ap-northeast-1a", "ap-northeast-1c"]
  vpc_zone_identifier = ["${aws_subnet.example.*.id}"]
  load_balancers = ["${aws_elb.example.name}"]
  max_size = "${var.blue_instances}"
  min_size = "${var.blue_instances}"
}

resource "aws_launch_configuration" "green" {
  image_id = "${var.ami}"
  name_prefix = "green-"
  instance_type = "${var.instance_type}"
  key_name = "tjinjin-terraform"
  security_groups = ["${aws_security_group.example.id}"]
  user_data = "${file("./boot-green.sh")}"

  root_block_device {
    delete_on_termination = "false"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "green" {
  name = "green"
  launch_configuration = "${aws_launch_configuration.green.id}"
  availability_zones = ["ap-northeast-1a", "ap-northeast-1c"]
  vpc_zone_identifier = ["${aws_subnet.example.*.id}"]
  load_balancers = ["${aws_elb.example.name}"]
  max_size = "${var.green_instances}"
  min_size = "${var.green_instances}"
}

output "dns_name" {
  value = "${aws_elb.example.dns_name}"
}
