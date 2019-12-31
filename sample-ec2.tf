# Create a new instance of the latest Ubuntu 14.04 on an
# t2.micro node with an AWS Tag naming it "HelloWorld"
provider "aws" {
  region = "eu-central-1"
}

data "aws_ami" "example" {
  executable_users = ["self"]
  most_recent      = true
  owners           = ["self"]


  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
data "aws_ami_ids" "ubuntu-ids" {
  owners = ["self"]

  filter {
    name   = "name"
    values = ["Ubuntu Server 18.04 LTS (HVM)"]
  }
}

resource "aws_instance" "web" {
  ami           = "ami-010fae13a16763bb4"
  #ami           = "${data.aws_ami.amazon-linux-2.id}"
  instance_type = "t2.micro"
  availability_zone = "eu-central-1b"

  tags = {
    Name        = "NY-test-EC2"
    Environment = "Sandbox",
    Owner       = "Narendra"
  }
}

output "ami_ids" {
  value = "${data.aws_ami_ids.ubuntu-ids.*.ids}"
}
output "amiids" {
  value = "${data.aws_ami.example.id}"
}


