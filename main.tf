 # configure aws provider
 # insert access keys created in IAM under user
provider "aws" {
  access_key = ""
  secret_key = ""
  region = "us-east-1"
  #profile = "Admin"
}

# create instance and specify the subnet that exists within the vpc you are trying to use
resource "aws_instance" "tf_activity" {
  ami = "ami-08c40ec9ead489470"
  instance_type = "t2.micro"
  vpc_security_group_ids = "sg-0d3b35d6cac538da3"
#associate the new instance with this subnet inside the vpc of your choosing
  subnet_id = "subnet-0172bafc656970b2d"
  associate_public_ip_address = true
  key_name = "NalaniDaniels894key"
  user_data = "${file("jenkins.sh")}"

  tags = {
    "Name" : "tf_activity"
  }




#output the ip address to the terminal
output "instance_ip" {
  value = aws_instance.tf_activity.public_ip
}
