resource "aws_instance" "example" {
  ami           = "ami-0532be01f26a3de55"
  instance_type = "t3.micro"
  key_name      = "aws_ec2_key"
  vpc_security_group_ids = [
    aws_security_group.allow_ssh.id
  ]

  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "ec2_sg"
  description = "Allow SSH inbound traffic"

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.allow_ssh.id
  cidr_ipv4         = "142.122.154.227/32"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_key_pair" "deployer" {
  key_name   = "aws_ec2_key"
  public_key = file("/Users/practice/.ssh/aws_ec2_key.pub")
}


