# Create a new instance of the latest Ubuntu 14.04 on an
# t2.micro node with an AWS Tag naming it "HelloWorld"
provider "aws" {
  region = "eu-central-1"
}


data "aws_ami" "amazon-linux-2" {
 most_recent = true
 owners = ["self"]

 filter {
   name   = "owner-alias"
   values = ["amazon"]
 }

 filter {
   name   = "name"
   values = ["amzn2-ami-hvm*"]
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
  #ami           = "ami-010fae13a16763bb4"
  ami           = "${data.aws_ami.amazon-linux-2.id}"
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
    value = "${data.aws_ami.amazon-linux-2.id}"
}
