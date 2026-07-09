data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical Ubuntu

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}


resource "aws_instance" "rke2_server" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.rke2_sg.id]
  key_name                    = aws_key_pair.rke2_key.key_name
  associate_public_ip_address = true

  root_block_device {
    volume_size = 40
    volume_type = "gp3"
  }

  tags = {
    Name    = "rke2-single-node-server"
    Project = "secure-rke2-platform"
  }
}

resource "aws_eip" "rke2_eip" {
  domain = "vpc"

  instance = aws_instance.rke2_server.id

  tags = {
    Name    = "rke2-eip"
    Project = "secure-rke2-platform"
  }
}