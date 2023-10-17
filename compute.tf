# Create EC2 ( only after RDS is provisioned)
resource "aws_instance" "wordpressec2" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = ["${aws_security_group.ec2_allow_rule.id}"]
  user_data              = data.template_file.user_data.rendered
  key_name               = aws_key_pair.generated_key.key_name
  tags = {
    Name = "Wordpress.web"
  }

  root_block_device {
    volume_size = 22 # in GB 

  }

  # this will stop creating EC2 before RDS is provisioned
  depends_on = [aws_db_instance.wordpressdb]
}

# creating Elastic IP for EC2
resource "aws_eip" "eip" {
  instance = aws_instance.wordpressec2.id

}

# # Create an ec2 instance
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

# resource "aws_instance" "mysql" {
#   ami                    = "ami-04e98b8bcc00d2678"
#   instance_type          = "t2.micro"
#   key_name               = aws_key_pair.generated_key.key_name
#   vpc_security_group_ids = ["${aws_security_group.my_sg.id}"]
#   subnet_id              = aws_subnet.private.id

#   tags = {
#     Name = "MySQL_instance_name"
#   }
# }


#AWS Instance
# resource "aws_instance" "example" {
#     ami = data.aws_ami.windows.id
#     instance_type = "t2.micro"
#     availability_zone = var.availability_zone

#   lifecycle {
#     ignore_changes = [ami]
#   }
# }

#AMI Filter for Windows Server 2019 Base
data "aws_ami" "windows" {
  most_recent = true

  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["801119661308"] # Canonical
}

data "aws_ami" "linux2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }


  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ami" "ubuntu" {

  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}