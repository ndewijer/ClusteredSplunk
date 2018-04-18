resource "aws_security_group" "nat-private-public" {
  name = "VPC_Nat_Private_Public"
  description = "Allow traffic to pass from the private subnet to the internet"

  #incomming
  ingress { # HTTP
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["${var.private_subnet_cidr}"]
  }

  ingress { #HTTPS
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["${var.private_subnet_cidr}"]
  }

  ingress { #PING
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress { #SSH
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress { #RDP
    from_port = 3389
    to_port = 3389
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #outgoing

egress { #HTTP
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress { #HTTPS
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress { #PING
      from_port = -1
      to_port = -1
      protocol = "icmp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress { #SSH
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress { #RDP
    from_port = 3389
    to_port = 3389
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.nick.id}"

  tags {
    Name = "VPC_Nat_Private_Public"
  }
}

resource "aws_security_group" "public_to_internet" {
  name = "VPC_Public_Internet"
  description = "Allow traffic to pass from the public subnet to the internet"

  #incomming
  ingress { # HTTP
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress { #HTTPS
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress { #SSH
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress { #Splunk Data
    from_port = 9997
    to_port = 9997
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress { #Splunk Apps
    from_port = 8089
    to_port = 8089
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress { #Splunk Web
    from_port = 8000
    to_port = 8000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress { #HTTP
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress { #HTTPS
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress { #SSH
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   egress { #Splunk Data
    from_port = 9997
    to_port = 9997
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress { #Splunk Apps
    from_port = 8089
    to_port = 8089
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress { #Splunk Web
    from_port = 8000
    to_port = 8000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.nick.id}"

  tags {
    Name = "VPC_Public_Internet"
  }
}