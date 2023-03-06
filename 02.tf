# Configure the AWS provider
provider "aws" {
  region = "us-west-2"
}

# Create three EC2 instances
resource "aws_instance" "example_instances" {
  count         = 3
  ami           = "ami-9173717231723213"
  instance_type = "t2.micro"
  tags = {
    Name = "example-instance-${count.index + 1}"
  }
}
