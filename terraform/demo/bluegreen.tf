resource "aws_launch_configuration" "blue" {
    image_id = "${var.blue_ami}"
    name = "blue-launch_configration"
    instance_type = "${var.blue_instance_type}"
    key_name = "${var.key_name}"
    security_groups = ["${aws_security_group.private_instances.id}"]
    user_data = "${file("./boot-blue.sh")}"

    root_block_device {
        delete_on_termination = true
    }
}

resource "aws_autoscaling_group" "blue" {
    name = "blue"
    launch_configuration = "${aws_launch_configuration.blue.id}"
    availability_zones = ["ap-northeast-1a", "ap-northeast-1c"]
    vpc_zone_identifier = ["${aws_subnet.private.*.id}"]
    load_balancers = ["${aws_elb.blue.id}"]
    max_size = "${var.blue_instances}"
    min_size = "${var.blue_instances}"
}

resource "aws_launch_configuration" "green" {
    image_id = "${var.green_ami}"
    name = "green-launch_configration"
    instance_type = "${var.green_instance_type}"
    key_name = "${var.key_name}"
    security_groups = ["${aws_security_group.private_instances.id}"]
    user_data = "${file("./boot-green.sh")}"

    root_block_device {
      delete_on_termination = true
    }
}

resource "aws_autoscaling_group" "green" {
    name = "green"
    launch_configuration = "${aws_launch_configuration.green.id}"
    availability_zones = ["ap-northeast-1a", "ap-northeast-1c"]
    vpc_zone_identifier = ["${aws_subnet.private.*.id}"]
    load_balancers = ["${aws_elb.blue.id}"]
    max_size = "${var.green_instances}"
    min_size = "${var.green_instances}"
}

output "elb_dns_name" {
  value = "${aws_elb.blue.dns_name}"
}
