resource "aws_instance" "aws05_bastion" {
    ami = data.aws_ami.ubuntu.image_id
    instance_type = "t2.micro"
    key_name = "aws05-key"
    vpc_security_group_ids = [aws_security_group.aws05_ssh_sg.id]
    subnet_id = data.terraform_remote_state.aws05_vpc.outputs.public_subnet2a
    availability_zone = "ap-northeast-2a"
    # 퍼블릭 IP 할당 여부
    associate_public_ip_address = true

    tags = {
        Name = "aws05-bastion"
    }
}

resource "aws_security_group" "aws05_ssh_sg" {
    name = "aws05_ssh_sg"
    description = "security group for ssh server"
    vpc_id = data.terraform_remote_state.aws05_vpc.outputs.vpc_id

ingress {
    description = "For ssh port"
    from_port = 22
    to_port   = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "aws05_ssh_sg"
  }
}

