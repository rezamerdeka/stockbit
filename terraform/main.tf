provider "aws" {
        region                  = "ap-southeast-2"
        shared_credentials_file = "/home/ubuntu/.aws/credentials"
}

#resource "aws_s3_bucket" "this" {
#  bucket                               = "${var.bucket_name}"
#  acl                                  = "${var.acl_value}"
#  force_destroy                        = "${var.force_destroy}"
#  tags                                 = "${merge(var.tags, map("Name", format("%s", var.bucket_name)))}"
#}

#resource "aws_s3_bucket_object" "object" {
#  bucket = aws_s3_bucket.this.id
#  key    = "docker-compose.yml"
#  acl    = "private"
#  source = "../docker-compose.yml"
#  etag = filemd5("../docker-compose.yml")
#}


resource "aws_instance" "ec2" {
  ami           = "${var.ami}"
  instance_type = "${var.type}"
  key_name	= "terraform"
  availability_zone = "${var.zone}"
  subnet_id = "${var.subnet}"
  vpc_security_group_ids = ["${aws_security_group.terraform-sg.id}"]
  user_data = "${file("install.sh")}" 

  tags = {
    Name = "${var.product}-${var.environment}"
  }
}

resource "aws_security_group" "terraform-sg" {
  name        = "${var.product}-${var.environment}-sg"
  description = "Allow inbound traffic"
  vpc_id      = "${var.vpcid}"

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Golang API"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.product}-sg"
  }
}

