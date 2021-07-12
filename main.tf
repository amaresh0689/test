provider "aws" {
  region = "eu-central-1"
}

resource "aws_vpc" "cldcvr_vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "cldcvr-vpc"
  }
}

resource "aws_subnet" "cldcvr_subnet" {
  vpc_id            = aws_vpc.cldcvr_vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "eu-central-1"

  tags = {
    Name = "cldcvr-subnet"
  }
}

resource "aws_instance" "codepipes" {
  ami = "ami-13b8337c"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.cldcvr_subnet.id}"
}

resource "aws_s3_bucket" "cldcvr-s3" {
  bucket = "cldcvr"
  depends_on = ["aws_instance.codepipes"] # Dependency to EC2-Instance
}
 
