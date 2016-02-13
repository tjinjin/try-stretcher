resource "aws_instance" "bastion" {
    ami = "${var.bastion_ami}"
    instance_type = "${var.bastion_instance_type}"
    key_name = "${var.key_name}"
    security_groups = ["${aws_security_group.bastion.id}"]
    subnet_id = "${aws_subnet.public.0.id}"
    root_block_device {
        delete_on_termination = "true"
    }
    tags {
        Name = "demo"
        Roles = "bastion"
        Created = "terraform"
    }
}

output "bastion_dns_name" {
    value = "${aws_instance.bastion.dns_name}"
}
