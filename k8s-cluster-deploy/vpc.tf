resource "aws_vpc" "project-k8s-vpc" {
  cidr_block = "172.168.0.0/16"
  enable_dns_hostnames = true
  enable_classiclink = false
  enable_dns_support = true
    tags = {
    Name = "project-k8s-vpc"
  }
}

resource "aws_internet_gateway" "project-igw" {
  vpc_id = aws_vpc.project-k8s-vpc.id
  tags = {
    Name = "project-igw"
  }
}

resource "aws_subnet" "k8s-public-subnet-1a" {
  cidr_block = "172.168.1.0/24"
  vpc_id = aws_vpc.project-k8s-vpc.id
  availability_zone = "us-east-1a"
    tags = {
    Name = "k8s-public-subnet-1a"
  }
}

resource "aws_subnet" "k8s-public-subnet-1b" {
  cidr_block = "172.168.2.0/24"
  vpc_id = aws_vpc.project-k8s-vpc.id
  availability_zone = "us-east-1b"
  tags = {
    Name = "k8s-public-subnet-1b"
  }
}

resource "aws_subnet" "k8s-public-subnet-1c" {
  cidr_block = "172.168.3.0/24"
  vpc_id = aws_vpc.project-k8s-vpc.id
  availability_zone = "us-east-1c"
  tags = {
    Name = "k8s-public-subnet-1c"
  }
}
resource "aws_route_table" "project-public-rt" {
  vpc_id = aws_vpc.project-k8s-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project-igw.id
  }
  tags = {
    Name = "project-public-rt"
  }
}
/**
resource "aws_subnet" "subnets" {
  count = "${length(var.k8s-vpc-public-subnet)}"
  cidr_block = "${element(var.k8s-vpc-public-subnet, count.index)}"
  availability_zone = "${element(var.vpc_subnet_azs, count.index)}"
  vpc_id = aws_vpc.project-k8s-vpc.id
  tags = {
    Name = "${element(var.vpc_subnet_names, count.index )}"
  }
}
**/
resource "aws_route_table_association" "project-public-rt-association-1a" {
  subnet_id = aws_subnet.k8s-public-subnet-1a.id
  route_table_id = aws_route_table.project-public-rt.id
}

resource "aws_route_table_association" "project-public-rt-association-1b" {
  subnet_id = aws_subnet.k8s-public-subnet-1b.id
  route_table_id = aws_route_table.project-public-rt.id
}

resource "aws_route_table_association" "project-public-rt-association-1c" {
  subnet_id = aws_subnet.k8s-public-subnet-1c.id
  route_table_id = aws_route_table.project-public-rt.id
}

resource "aws_security_group" "k8s_sg_public" {
  vpc_id = aws_vpc.project-k8s-vpc.id
  description = "Terraform practice security group"

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    #cidr_blocks = [aws_vpc.project-k8s-vpc.cidr_block]
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    #cidr_blocks = [aws_vpc.project-k8s-vpc.cidr_block]
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 0
    protocol = "tcp"
    to_port = 65535
    cidr_blocks = [aws_subnet.k8s-public-subnet-1a.cidr_block, aws_subnet.k8s-public-subnet-1b.cidr_block, aws_subnet.k8s-public-subnet-1c.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "k8s_sg_public"
  }
}