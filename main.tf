provider "aws" {
  region = "us-east-1"
}

# Define the EC2 instance
resource "aws_instance" "app_server" {
  ami           = "ami-0c9b9f8021f61b434"
  instance_type = "t2.small"

#   # Assign the security group to the instance
#   vpc_security_group_ids = [aws_security_group.app_sg.id]

  # Add a tag to the instance
#   tags = {
#     Name = "JavaMicroserviceInstance"
#   }
}

# Define the Security Group to allow SSH and HTTP traffic
resource "aws_security_group" "app_sg" {
  name        = "app_sg"
  description = "Allow SSH and HTTP traffic"

  # Inbound rule to allow SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Inbound rule to allow HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rule to allow all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Output the public IP address of the EC2 instance
output "instance_public_ip" {
  value = aws_instance.app_server.public_ip
}

