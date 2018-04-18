resource "aws_vpc" "nick" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  tags {
    Name = "Nicks-VPC"
  }
}

resource "aws_internet_gateway" "vpcInternetGateway" {
  vpc_id = "${aws_vpc.nick.id}"
}

resource "aws_route" "Internet_Access" {
  route_table_id = "${aws_vpc.nick.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.vpcInternetGateway.id}"
}

