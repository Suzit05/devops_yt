provider "aws" {
  region = "eu-north-1"
}

# curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | gpg --dearmor | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
resource "aws_key_pair" "log_key" {
  key_name = "jenkins-cicd-key"
  public_key = file("/mnt/c/Users/sujee/.ssh/id_rsa.pub")
}

resource "aws_security_group" "jenkins_sg" {
  name = "jenkins-sg"
  description = "security group for jenkins server"

  ingress {
    from_port = 22 #for ssh
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 8080 #for jenkins/http
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "myinstance" {
  ami = "ami-080254318c2d8932f"
  instance_type = "t3.micro"
  vpc_security_group_ids = [ aws_security_group.jenkins_sg.id ]
  key_name = aws_key_pair.log_key.key_name
  tags = {
    Name = "jenkins-ec2"
    Env = "Development"
  }
}

# eec4e156b5934fc4a3fed0f799cb49cf 
output "public_ip" {
  value = aws_instance.myinstance.public_ip
}