provider "aws" {
  region = "ap-south-1"
}


# # Create VPC
# resource "aws_vpc" "my_vpc" {
#   cidr_block           = "10.0.0.0/16"
#   instance_tenancy     = "default"
#   enable_dns_hostnames = "true"

#   tags = {
#     Name = "my_vpc"
#   }
# }

# resource "aws_security_group" "my_sg" {
#   name        = "my_sg"
#   description = "This firewall allows SSH, HTTP and MYSQL"
#   vpc_id      = aws_vpc.my_vpc.id

#   ingress {
#     description = "SSH"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     description = "HTTP"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     description = "HTTP"
#     from_port   = 1985
#     to_port     = 1985
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     description = "TCP"
#     from_port   = 3306
#     to_port     = 3306
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "my_sg"
#   }
# }

# resource "aws_subnet" "public" {
#   vpc_id                  = aws_vpc.my_vpc.id
#   cidr_block              = "10.0.0.0/24"
#   availability_zone       = "ap-south-1a"
#   map_public_ip_on_launch = "true"

#   tags = {
#     Name = "my_public_subnet"
#   }
# }

# resource "aws_subnet" "private" {
#   vpc_id            = aws_vpc.my_vpc.id
#   cidr_block        = "10.0.1.0/24"
#   availability_zone = "ap-south-1b"

#   tags = {
#     Name = "my_private_subnet"
#   }
# }

# resource "aws_internet_gateway" "my_ig" {
#   vpc_id = aws_vpc.my_vpc.id

#   tags = {
#     Name = "My internet gateway"
#   }
# }

# resource "aws_route_table" "rt" {
#   vpc_id = aws_vpc.my_vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.my_ig.id
#   }

#   tags = {
#     Name = "My route table"
#   }
# }

# resource "aws_route_table_association" "a" {
#   subnet_id      = aws_subnet.public.id
#   route_table_id = aws_route_table.rt.id
# }

# resource "aws_route_table_association" "b" {
#   subnet_id      = aws_subnet.private.id
#   route_table_id = aws_route_table.rt.id
# }

# resource "aws_instance" "wordpress" {
#   ami                    = data.aws_ami.ubuntu.id
#   instance_type          = "t2.micro"
#   key_name               = aws_key_pair.generated_key.key_name
#   vpc_security_group_ids = ["${aws_security_group.my_sg.id}"]
#   subnet_id              = aws_subnet.public.id

#   user_data = "${file("init.sh")}"

#   tags = {
#     Name = "My wordpress_instance_name"
#   }
# }

# # resource "aws_instance" "mysql" {
# #   ami                    = "ami-04e98b8bcc00d2678"
# #   instance_type          = "t2.micro"
# #   key_name               = aws_key_pair.generated_key.key_name
# #   vpc_security_group_ids = ["${aws_security_group.my_sg.id}"]
# #   subnet_id              = aws_subnet.private.id

# #   tags = {
# #     Name = "MySQL_instance_name"
# #   }
# # }


# #AWS Instance
# # resource "aws_instance" "example" {
# #     ami = data.aws_ami.windows.id
# #     instance_type = "t2.micro"
# #     availability_zone = var.availability_zone

# #   lifecycle {
# #     ignore_changes = [ami]
# #   }
# # }

# #AMI Filter for Windows Server 2019 Base
# data "aws_ami" "windows" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["Windows_Server-2019-English-Full-Base-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   owners = ["801119661308"] # Canonical
# }

# data "aws_ami" "linux2" {
#   most_recent = true
#   owners      = ["amazon"]

#   filter {
#     name   = "name"
#     values = ["amzn2-ami-hvm-*-x86_64-gp2"]
#   }


#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
# }

# data "aws_ami" "ubuntu" {

#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
# }