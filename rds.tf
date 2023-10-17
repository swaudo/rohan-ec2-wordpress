# Create RDS instance
resource "aws_db_instance" "wordpressdb" {
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro" //type of RDS Instance
  db_subnet_group_name   = aws_db_subnet_group.RDS_subnet_grp.id
  vpc_security_group_ids = ["${aws_security_group.RDS_allow_rule.id}"]
  db_name                = "wordpress_db"
  username               = "wordpress_user"
  password               = "PassWord4-user"
  skip_final_snapshot    = true

  # make sure rds manual password chnages is ignored
  lifecycle {
    ignore_changes = [password]
  }
}

# change USERDATA varible value after grabbing RDS endpoint info
data "template_file" "user_data" {
  # template = var.IsUbuntu ? file("${path.module}/userdata_ubuntu.tpl") : file("${path.module}/user_data.tpl")
  # template = "${file("init.sh")}"
  template = file("userdata_ubuntu.tpl")
  vars = {
    db_username      = "wordpress_user"
    db_user_password = "PassWord4-user"
    db_name          = "wordpress_db"
    db_RDS           = aws_db_instance.wordpressdb.endpoint
  }
}