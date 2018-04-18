resource "aws_subnet" "eu-west-2a-private" {
  vpc_id = "${aws_vpc.nick.id}"
  cidr_block = "${var.private_subnet_cidr}"
  #availability_zone = "eu-west-2a"
  availability_zone = "${var.aws_AZ_a}"

  tags {
    Name = "Private Subnet"
  }
}