provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "project" {
  ami                         = var.amis["20.04"]
  instance_type               = var.instance_types[0]
  associate_public_ip_address = true # Assign a public IP to this instance
  key_name                    = "master"
  subnet_id                   = aws_subnet.project-subnet.id
  tags = {
    Name = "web-server"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"                         # Update with appropriate username
    private_key = file("/home/ubuntu/.ssh/master") # Path to your private key
    host        = self.public_ip                   # Use the public IP of the instance

  }

  provisioner "file" {
    source      = "/home/ubuntu/.ssh/master.pub" # Path to your local public key
    destination = "/tmp/master.pub"              # Temporary location on the instance
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p /home/ubuntu/.ssh", # Create .ssh directory if it doesn't exist
      "sudo chmod 700 /home/ubuntu/.ssh",
      "sudo cat /tmp/master.pub >> /home/ubuntu/.ssh/authorized_keys", # Copy public key to authorized_keys
      "echo 'adding the key'",
      "sudo chown -R  ubuntu:ubuntu /home/ubuntu/.ssh",   # Change ownership to ubuntu user
      "sudo chmod 644 /home/ubuntu/.ssh/authorized_keys", # Set correct permissions on authorized_keys
      "cat /etc/os-release"                               # A quick verification that the SSH was succcessfull

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
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_vpc" "project-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "project"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "project-igw" {
  vpc_id = aws_vpc.project-vpc.id
}

resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.project-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.project-vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.project-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project-igw.id
  }
}

resource "aws_route_table_association" "subnet1-association" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "subnet2-association" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_lb" "project-lb" {
  name               = "project-load-balancer"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.project-subnet.id, aws_subnet.project-subnet2.id]
}

# Create a target group for the load balancer
resource "aws_lb_target_group" "project-target_group" {
  name     = "project-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.project-vpc.id
}

resource "aws_eip" "project-eip" {
  instance = aws_instance.project.id
}

resource "aws_eip_association" "project-eip-assoc" {
  instance_id   = aws_instance.project.id
  allocation_id = aws_eip.project-eip.id
}

output "instance-ip" {
  value = aws_instance.project.public_ip
}