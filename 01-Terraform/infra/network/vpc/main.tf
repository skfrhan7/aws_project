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

resource "aws_internet_gateway" "aws05_igw" {
	vpc_id = aws_vpc.aws05_vpc.id

	tags = {
		Name = "aws05-Internet-gateway"
	}
}

resource "aws_eip" "aws05_eip" { 
	vpc = true
	depends_on = ["aws_internet_gateway.aws05_igw"]
	lifecycle {
		create_before_destroy = true
	}
}

resource "aws_nat_gateway" "aws05_nat" {
	allocation_id = aws_eip.aws05_eip.id
	subnet_id = aws_subnet.aws05_public_subnet2a.id
	depends_on = ["aws_internet_gateway.aws05_igw"]
}

resource "aws_default_route_table" "aws05_public_rt" {
  default_route_table_id = aws_vpc.aws05_vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws05_igw.id
  }
  tags = {
    Name = "aws05 public route table"
  }
}

resource "aws_route_table_association" "aws05_public_rta_2a" {
  subnet_id      = aws_subnet.aws05_public_subnet2a.id
  route_table_id = aws_default_route_table.aws05_public_rt.id
}

resource "aws_route_table_association" "aws05_public_rta_2c" {
  subnet_id      = aws_subnet.aws05_public_subnet2c.id
  route_table_id = aws_default_route_table.aws05_public_rt.id
}

resource "aws_route_table" "aws05_private_rt" {
	vpc_id = aws_vpc.aws05_vpc.id
	tags = {
		Name = "aws05 private route table"
	}
}

resource "aws_route_table_association" "aws05_private_rta_2a" {
  subnet_id      = aws_subnet.aws05_private_subnet2a.id
  route_table_id = aws_route_table.aws05_private_rt.id
}

resource "aws_route_table_association" "aws05_private_rta_2c" {
  subnet_id      = aws_subnet.aws05_private_subnet2c.id
  route_table_id = aws_route_table.aws05_private_rt.id
}

resource "aws_route" "aws05_private_rt_table" {
	route_table_id = aws_route_table.aws05_private_rt.id
	destination_cidr_block = "0.0.0.0/0"
	nat_gateway_id = aws_nat_gateway.aws05_nat.id
}