provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami = "ami-0fc5d935ebf8bc3bc"
  instance_type = "t2.micro"
  key_name = "cicd"
  tags = {
    Name = "Devops-NodeAPP"
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} > ../ansible/hosts"
  }
}
