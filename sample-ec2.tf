# Create a new instance of the latest Ubuntu 14.04 on an
# t2.micro node with an AWS Tag naming it "HelloWorld"
provider "aws" {
  region = "eu-central-1"
}


data "aws_ami" "ubuntu" {
  executable_users = ["self"]
  most_recent      = true
  name_regex       = "Ubuntu Server 18.04 LTS (HVM)"
  owners           = ["self"]
/*
  filter {
    name   = "name"
    values = ["ami-0c64dd618a49aeee8-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  } */

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
} 
  
data "aws_ami_ids" "ubuntu" {
  owners = ["self"]

  filter {
    name   = "name"
    values = ["Ubuntu Server 18.04 LTS (HVM)"]
  }
}

resource "aws_instance" "web" {
  #ami           = "ami-010fae13a16763bb4"
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"

  tags = {
    Name        = "NY-test-EC2"
    Environment = "Sandbox",
    Owner       = "Narendra"
  }
}

output "ami_ids" {
  value = "${data.aws_ami_ids.ubuntu.*.ids}"
}
