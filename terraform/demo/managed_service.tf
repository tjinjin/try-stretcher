resource "aws_nat_gateway" "demo" {
    allocation_id = "${aws_eip.nat_gateway.id}"
    subnet_id = "${aws_subnet.public.0.id}"
}

resource "aws_eip" "nat_gateway" {
    vpc = true
}
