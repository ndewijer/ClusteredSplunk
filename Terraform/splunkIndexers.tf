/* Splunk Box */
resource "aws_instance" "SI_01" {
  ami             = "ami-e7d6c983" #amazon-linux-ami
  #ami              = "ami-78657b1c" #Win 2016
  #instance_type   = "m4.xlarge"
  instance_type   = "t2.medium"
  availability_zone = "${var.aws_AZ_a}"
  subnet_id = "${aws_subnet.eu-west-2a-public.id}"
  associate_public_ip_address = true
  vpc_security_group_ids = ["${aws_security_group.public_to_internet.id}"]
  key_name = "${aws_key_pair.KeyPair_Nick.key_name}"

  tags {
    Name = "SI01"
  }

  volume_tags {
    Name = "SI01"
  }

 root_block_device {
    volume_type = "gp2"
    volume_size = "20"
    delete_on_termination = true
  }

  provisioner "chef" {
    environment     = "_default"
    run_list        = ["role[base]"]
    node_name       = "${aws_instance.SI_01.tags.Name}-${random_string.chef_node.result}"
    server_url      = "https://api.chef.io/organizations/s-l-b"
    recreate_client = true
    user_name       = "s-l-b-validator"
    user_key        = "${file("chef/s-l-b.pem")}"
    ssl_verify_mode = ":verify_peer"

    connection {
      type = "ssh"
      user = "ec2-user"
      port = 22
      private_key = "${file(var.private_key)}"
    }
  }
}

resource "aws_ebs_volume" "SI_01_splunk_volume" {
  availability_zone = "${var.aws_AZ_a}"
  size = 20
  tags {
    Name = "SI01-splunk"
  }
}

resource "aws_ebs_volume" "SI_01_hotwarm_volume" {
  availability_zone = "${var.aws_AZ_a}"
  size = 20
  tags {
    Name = "SI01-hotwarm"
  }
}

resource "aws_ebs_volume" "SI_01_cold_volume" {
  availability_zone = "${var.aws_AZ_a}"
  size = 20
  tags {
    Name = "SI01-cold"
  }
}

resource "aws_volume_attachment" "SI_01_splunk_volume_attach" {
  device_name = "/dev/xvdf"
  instance_id = "${aws_instance.SI_01.id}"
  volume_id = "${aws_ebs_volume.SI_01_splunk_volume.id}"
}

resource "aws_volume_attachment" "SI_01_splunk_hotwarm_attach" {
  device_name = "/dev/xvdg"
  instance_id = "${aws_instance.SI_01.id}"
  volume_id = "${aws_ebs_volume.SI_01_hotwarm_volume.id}"
}

resource "aws_volume_attachment" "SI_01_splunk_cold_attach" {
  device_name = "/dev/xvdh"
  instance_id = "${aws_instance.SI_01.id}"
  volume_id = "${aws_ebs_volume.SI_01_cold_volume.id}"
}

resource "aws_eip_association" "SI_01-eip" {
  instance_id   = "${aws_instance.SI_01.id}"
  allocation_id = "${var.ElasticIP-LB}"
}
