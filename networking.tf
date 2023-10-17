# Create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"

  tags = {
    Name = "my_vpc"
  }
}

# Create Public Subnet for EC2
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "my_public_subnet"
  }
}

# Create Private subnet for RDS
resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "my_private_subnet"
  }
}

# Create second Private subnet for RDS
resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-south-1c"

  tags = {
    Name = "my_second_private_subnet"
  }
}

# Create IGW for internet connection 
resource "aws_internet_gateway" "my_ig" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "My internet gateway"
  }
}

# Creating Route table
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_ig.id
  }

  tags = {
    Name = "My route table"
  }
}

# Associating route tabe to public subnet
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.rt.id
}

# resource "aws_route_table_association" "b" {
#   subnet_id      = aws_subnet.private.id
#   route_table_id = aws_route_table.rt.id
# }

# Create RDS Subnet group
resource "aws_db_subnet_group" "RDS_subnet_grp" {
  subnet_ids = ["${aws_subnet.private1.id}", "${aws_subnet.private2.id}"]
}


