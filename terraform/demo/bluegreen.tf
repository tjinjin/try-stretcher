resource "aws_launch_configuration" "blue" {
    image_id = "${var.blue_ami}"
    name = "blue-launch_configration"
    instance_type = "${var.blue_instance_type}"
    iam_instance_profile = "${var.project_name}-instance"
    key_name = "${var.key_name}"
    security_groups = ["${aws_security_group.private_instances.id}"]
    user_data = "${file("./boot-consul.sh")}"

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
    load_balancers = ["${aws_elb.blue.id}"]
    max_size = "${var.blue_instances}"
    provisioner "remote-exec" {
        inline = [
            "consul join ${aws_instance.bastion.private_ip}"
        ]
        connection {
          bastion_host = "${aws_instance.bastion.public_ip}"
          user = "centos"
          private_key = "~/.ssh/tjinjin-terraform.pem"
        }
    }

   min_size = "${var.blue_instances}"
}

resource "aws_launch_configuration" "green" {
    image_id = "${var.green_ami}"
    name = "green-launch_configration"
    instance_type = "${var.green_instance_type}"
    iam_instance_profile = "${var.project_name}-instance"
    key_name = "${var.key_name}"
    security_groups = ["${aws_security_group.private_instances.id}"]
    user_data = "${file("./boot-consul.sh")}"

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
    load_balancers = ["${aws_elb.blue.id}"]
    max_size = "${var.green_instances}"
    provisioner "remote-exec" {
        inline = [
            "consul join ${aws_instance.bastion.private_ip}"
        ]
        connection {
          bastion_host = "${aws_instance.bastion.publig_ip}"
          user = "centos"
          private_key = "~/.ssh/tjinjin-terraform.pem"
        }
    }

   min_size = "${var.green_instances}"
}

output "elb_dns_name" {
  value = "${aws_elb.blue.dns_name}"
}

output "aws"
