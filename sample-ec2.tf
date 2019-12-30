# Create a new instance of the latest Ubuntu 14.04 on an
# t2.micro node with an AWS Tag naming it "HelloWorld"
provider "aws" {
  region = "eu-central-1"
}

/*
data "aws_ami" "ubuntu" {
  executable_users = ["self"]
  most_recent      = true
  name_regex       = "^ami-0c64dd618a49aeee8-\\d{3}"
  owners           = ["self"]

  filter {
    name   = "name"
    values = ["ami-0c64dd618a49aeee8-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
} */

resource "aws_instance" "web" {
  ami           = "ami-0c64dd618a49aeee8"
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}
