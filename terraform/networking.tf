resource "aws_vpc" "rke2_vpc" {
  cidr_block           = "10.20.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name    = "rke2-vpc"
    Project = "secure-rke2-platform"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.rke2_vpc.id
  cidr_block              = "10.20.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${var.aws_region}a"

  tags = {
    Name    = "rke2-public-subnet"
    Project = "secure-rke2-platform"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.rke2_vpc.id

  tags = {
    Name    = "rke2-igw"
    Project = "secure-rke2-platform"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.rke2_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name    = "rke2-public-rt"
    Project = "secure-rke2-platform"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}