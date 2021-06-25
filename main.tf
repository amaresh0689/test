provider "aws" {
  region = "eu-central-1"
}
 
resource "aws_instance" "codepipes" {
  ami = "ami-13b8337c"
  instance_type = "t2.micro"
  tags
  {
  name = "codepipes test"
  }
}

resource "aws_s3_bucket" "cldcvr-s3" {
  bucket = "cldcvr"
  depends_on = ["aws_instance.codepipes"] # Dependency to EC2-Instance
}
 
