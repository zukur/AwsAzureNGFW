# VPC
resource "aws_vpc" "vpc-1" {
  cidr_block = "10.42.0.0/16"
  tags = {
    Name = "BTH-MC-VPC"
  }
}

# Subnets
resource "aws_subnet" "subnet_outside-3a" {
  vpc_id     = aws_vpc.vpc-1.id
  cidr_block = "10.42.1.0/24"
  availability_zone = "eu-west-3a"

  tags = {
    Name = "Outside-3a"
  }
}

resource "aws_subnet" "subnet_inside-3a" {
  vpc_id     = aws_vpc.vpc-1.id
  cidr_block = "10.42.2.0/24"
  availability_zone = "eu-west-3a"

  tags = {
    Name = "Inside-3a"
  }
}

resource "aws_subnet" "subnet_management-3a" {
  vpc_id     = aws_vpc.vpc-1.id
  cidr_block = "10.42.3.0/24"
  availability_zone = "eu-west-3a"

  tags = {
    Name = "Management-3a"
  }
}

resource "aws_subnet" "subnet_jumpbox-3a" {
  vpc_id     = aws_vpc.vpc-1.id
  cidr_block = "10.42.4.0/24"
  availability_zone = "eu-west-3a"

  tags = {
    Name = "Jumpbox-3a"
  }
}

resource "aws_subnet" "subnet_oobmgmt-3a" {
  vpc_id     = aws_vpc.vpc-1.id
  cidr_block = "10.42.250.0/24"
  availability_zone = "eu-west-3a"

  tags = {
    Name = "OOB-Mgmt-3a"
  }
}

resource "aws_subnet" "subnet_diag-3a" {
  vpc_id     = aws_vpc.vpc-1.id
  cidr_block = "10.42.255.0/24"
  availability_zone = "eu-west-3a"

  tags = {
    Name = "Diag-3a"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw-outside" {
  vpc_id = aws_vpc.vpc-1.id

  tags = {
    Name = "igw-outside"
  }
}

# Route table
resource "aws_route_table" "outside" {
  vpc_id = aws_vpc.vpc-1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-outside.id
  }

  tags = {
    Name = "rt-outside"
  }
}

resource "aws_route_table" "inside" {
  vpc_id = aws_vpc.vpc-1.id

  route {
    cidr_block = "0.0.0.0/0"
    network_interface_id = aws_network_interface.ftdv01-inside.id
  }

  tags = {
    Name = "rt-inside"
  }
}

resource "aws_route_table_association" "assoc-outside-3a" {
  subnet_id      = aws_subnet.subnet_outside-3a.id
  route_table_id = aws_route_table.outside.id
}

resource "aws_route_table_association" "assoc-inside-3a" {
  subnet_id      = aws_subnet.subnet_inside-3a.id
  route_table_id = aws_route_table.inside.id
}

resource "aws_route_table_association" "assoc-oobmgmt-3a" {
  subnet_id      = aws_subnet.subnet_oobmgmt-3a.id
  route_table_id = aws_route_table.outside.id
}

resource "aws_route_table_association" "assoc-mgmt-3a" {
  subnet_id      = aws_subnet.subnet_management-3a.id
  route_table_id = aws_route_table.outside.id
}

resource "aws_route_table_association" "assoc-jmpbox-3a" {
  subnet_id      = aws_subnet.subnet_jumpbox-3a.id
  route_table_id = aws_route_table.inside.id
}