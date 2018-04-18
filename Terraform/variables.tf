variable "aws_region" {
  description = "EC2 Region for the VPC"
  default = "eu-west-2"
}

variable "aws_AZ_a" {
  description = "Define AZ A to use within Region"
  default = "eu-west-2a"
}

variable "aws_AZ_b" {
  description = "Define AZ B to use within Region"
  default = "eu-west-2b"
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
  default = "10.1.0.0/16"
}

variable "private_subnet_cidr" {
  description = "CIDR for Private subnet"
  default = "10.1.0.0/24"
}


variable "public_subnet_cidr" {
  description = "CIDR for Public subnet"
  default = "10.1.1.0/24"
}

variable "private_key" {
    default = "SigningKey_Priv.pem"
}

variable "keypair" {
  default = "KeyPair.ppk"
}

variable "ElasticIP-LB" { 
  default = "eipalloc-38440216"
}

resource "random_string" "chef_node" {
  length = 5
  special = false
}