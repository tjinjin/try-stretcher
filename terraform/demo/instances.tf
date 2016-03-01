resource "aws_instance" "bastion" {
    ami = "${var.bastion_ami}"
    instance_type = "${var.bastion_instance_type}"
    iam_instance_profile = "${var.project_name}-instance"
    key_name = "${var.key_name}"
    security_groups = ["${aws_security_group.bastion.id}"]
    subnet_id = "${aws_subnet.public.0.id}"
    user_data = "${file("./boot-bastion.sh")}"
    root_block_device {
        delete_on_termination = "true"
    }
    tags {
        Name = "demo"
        Roles = "bastion"
        Created = "terraform"
    }
}

output "bastion_ip" {
    value = "${aws_instance.bastion.public_ip}"
}
