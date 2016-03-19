resource "template_file" "boot_web" {
    template = "${file("./boot-web.sh.tpl")}"

    vars {
        bastion_private_ip = "${aws_instance.bastion.private_ip}"
    }

    lifecycle = {
        create_before_destroy = true
    }
}

resource "aws_launch_configuration" "blue" {
    image_id = "${var.blue_ami}"
    name = "blue-launch_configration"
    instance_type = "${var.blue_instance_type}"
    iam_instance_profile = "${var.project_name}-instance"
    key_name = "${var.key_name}"
    security_groups = ["${aws_security_group.private_instances.id}"]
    user_data = "${template_file.boot_web.rendered}"

    root_block_device {
        delete_on_termination = true
    }

    lifecycle = {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "blue" {
    name = "blue"
    launch_configuration = "${aws_launch_configuration.blue.id}"
    availability_zones = ["ap-northeast-1a", "ap-northeast-1c"]
    vpc_zone_identifier = ["${aws_subnet.private.*.id}"]
    load_balancers = ["${aws_elb.common.id}"]
    max_size = "${var.blue_instances}"
    min_size = "${var.blue_instances}"

    lifecycle = {
        create_before_destroy = true
    }
    tag {
      key = "Role"
      value = "web"
      propagate_at_launch = true
    }
    tag {
      key = "Color"
      value = "green"
      propagate_at_launch = true
    }
}

resource "aws_launch_configuration" "green" {
    image_id = "${var.green_ami}"
    name = "green-launch_configration"
    instance_type = "${var.green_instance_type}"
    iam_instance_profile = "${var.project_name}-instance"
    key_name = "${var.key_name}"
    security_groups = ["${aws_security_group.private_instances.id}"]
    user_data = "${template_file.boot_web.rendered}"

    root_block_device {
      delete_on_termination = true
    }

    lifecycle = {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "green" {
    name = "green"
    launch_configuration = "${aws_launch_configuration.green.id}"
    availability_zones = ["ap-northeast-1a", "ap-northeast-1c"]
    vpc_zone_identifier = ["${aws_subnet.private.*.id}"]
    load_balancers = ["${aws_elb.common.id}"]
    max_size = "${var.green_instances}"
    min_size = "${var.green_instances}"

    lifecycle = {
        create_before_destroy = true
    }
    tag {
      key = "Role"
      value = "web"
      propagate_at_launch = true
    }
    tag {
      key = "Color"
      value = "green"
      propagate_at_launch = true
    }
}
