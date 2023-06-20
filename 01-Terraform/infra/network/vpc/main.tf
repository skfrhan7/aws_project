resource "aws_vpc" "aws05_vpc" {
	cidr_block = var.vpc_cidr
	enable_dns_hostnames = true
	enable_dns_support = true
	instance_tenancy = "default"

	tags = {
		Name = "aws05_vpc"
	}
}

resource "aws_subnet" "aws05_public_subnet2a" {
	vpc_id = aws_vpc.aws05_vpc.id
	cidr_block = var.public_subnet[0]
	availability_zone = var.azs[0]

	tags = {
		Name = "aws05_public_subnet2a"
	}
}

resource "aws_subnet" "aws05_public_subnet2c" {
	vpc_id = aws_vpc.aws05_vpc.id
	cidr_block = var.public_subnet[1]
	availability_zone = var.azs[1]

	tags = {
		Name = "aws05_public_subnet2c"
	}
}

resource "aws_subnet" "aws05_private_subnet2a" {
	vpc_id = aws_vpc.aws05_vpc.id
	cidr_block = var.private_subnet[0]
	availability_zone = var.azs[0]

	tags = {
		Name = "aws05_private_subnet2a"
	}
}

resource "aws_subnet" "aws05_private_subnet2c" {
	vpc_id = aws_vpc.aws05_vpc.id
	cidr_block = var.private_subnet[1]
	availability_zone = var.azs[1]

	tags = {
		Name = "aws05_private_subnet2c"
	}
}
