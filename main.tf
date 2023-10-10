 # configure aws provider
 # insert access keys created in IAM under user
provider "aws" {
  access_key = ""
  secret_key = ""
  region = "us-east-1"
  #profile = "Admin"
}

# create instance
resource "aws_instance" "tf_activity" {
  ami = "ami-08c40ec9ead489470"
  instance_type = "t2.micro"
  vpc_security_group_ids = "sg-0d3b35d6cac538da3"
  subnet_id = "subnet-0172bafc656970b2d"
  key_name = "NalaniDaniels894key"
  user_data = "${file("jenkins.sh")}"

  tags = {
    "Name" : "tf_activity"
  }

}

# specify the vpc of choice
resource "aws_vpc" "d4-vpc" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "d4-vpc"
  }
}

# specify public subnet B
resource "aws_subnet" "d4-subnet-public2-us-east-1b" {
  vpc_id     = "vpc-0ae4e52dd4c2adcdd"
  cidr_block = "10.0.16.0/20"
  availability_zone = "us-east-1b"


  tags = {
    Name = "d4-subnet-public2-us-east-1b"
  }
}

#output the ip address to the terminal
output "instance_ip" {
  value = aws_instance.tf_activity.public_ip
}
