# Create a new instance of the latest Ubuntu 14.04 on an
# t2.micro node with an AWS Tag naming it "HelloWorld"
provider "aws" {
  #region = "eu-central-1"
  region  = "eu-west-2"
}


data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["self"] # Canonical
}
  
data "aws_ami_ids" "ubuntu-ids" {
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
  value = "${data.aws_ami_ids.ubuntu-ids.*.ids}"
}

output "image_id" {
    value = "${data.aws_ami.ubuntu.id}"
}
