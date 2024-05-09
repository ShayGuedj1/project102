provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "project1" {
  ami                         = var.amis["20.04"]
  instance_type               = var.instance_types[0]
  associate_public_ip_address = true # Assign a public IP to this instance
  key_name                    = "master"
  tags = {
    Name = "web-server"
  }
  security_groups = [var.security_groups["docker_sg"]]

  connection {
    type        = "ssh"
    user        = "ubuntu"                         # Update with appropriate username
    private_key = file("/home/ubuntu/.ssh/master") # Path to your private key
    host        = self.public_ip                   # Use the public IP of the instance
    
  }

  provisioner "file" {
    source      = "/home/ubuntu/.ssh/master.pub" # Path to your local public key
    destination = "/tmp/master.pub"   # Temporary location on the instance
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p /home/ubuntu/.ssh",                            # Create .ssh directory if it doesn't exist
      "sudo chmod 700 /home/ubuntu/.ssh",
      "sudo cat /tmp/master.pub >> /home/ubuntu/.ssh/authorized_keys", # Copy public key to authorized_keys
      "echo 'adding the key'",
      "sudo chown -R  ubuntu:ubuntu /home/ubuntu/.ssh",              # Change ownership to ubuntu user
      "sudo chmod 644 /home/ubuntu/.ssh/authorized_keys" ,           # Set correct permissions on authorized_keys
      "cat /etc/os-release"
      
    ]
  }


}
resource "aws_security_group" "project-sg" {
  name        = "project-sg"
  description = "Allow HTTP 8080 inbound traffic"
  # Define ingress rules
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Define egress rule for all traffic
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

output "instance-ip" {
  value = aws_instance.project1.public_ip
}