
### Create an ec2 instance that will be used as web server in public subnet
resource "aws_instance" "webserver" {

  ami                         = var.ami_id    ### data.aws_ami.instance_ami.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.websever_key.key_name
  subnet_id                   = aws_subnet.awslab-subnet-public.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.public_ports_security_groups.id]

  user_data = <<-EOF
    #!/bin/bash
    sudo su
    yum update -y
    yum install -y httpd
    systemctl start httpd.service
    systemctl enable httpd.service
    echo "Hello Cocus" > /var/www/html/index.html
    EOF

  tags = {
    Name = "ec2-webserver"
  }

}

# Create private key
resource "tls_private_key" "webserver_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "private_key" {
  content         = tls_private_key.webserver_private_key.private_key_pem
  filename        = "webserver_key.pem"
  file_permission = 0400
}

# add private key to aws file
resource "aws_key_pair" "websever_key" {
  key_name   = "webserver"
  public_key = tls_private_key.webserver_private_key.public_key_openssh
}


### Create an ec2 instance in private subnet that will be used for database
resource "aws_instance" "mysql-server" {

  ami                    = var.ami_id    ###data.aws_ami.instance_ami.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.awslab-subnet-private.id
  vpc_security_group_ids = [aws_security_group.private_ports_security_groups.id]

  tags = {
    Name = "ec2-database"
  }

}

