resource "random_id" "suffix" {
  byte_length = 4
}

resource "tls_private_key" "rke2_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  content         = tls_private_key.rke2_key.private_key_pem
  filename        = "${path.module}/rke2-key.pem"
  file_permission = "0400"
}

resource "aws_key_pair" "rke2_key" {
  key_name   = "rke2-key-${random_id.suffix.hex}"
  public_key = tls_private_key.rke2_key.public_key_openssh
}

resource "aws_security_group" "rke2_sg" {
  name        = "rke2-sg-${random_id.suffix.hex}"
  description = "Security group for RKE2 lab"
  vpc_id      = aws_vpc.rke2_vpc.id

  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.my_public_ip}/32"]
  }

  ingress {
    description = "Kubernetes API from my IP"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["${var.my_public_ip}/32"]
  }

  ingress {
    description = "HTTP from my IP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.my_public_ip}/32"]
  }

  ingress {
    description = "HTTPS from my IP"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.my_public_ip}/32"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "rke2-security-group"
    Project = "secure-rke2-platform"
  }
}