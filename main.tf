provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "project" {
  ami                         = var.amis["20.04"]
  instance_type               = var.instance_types[0]
  associate_public_ip_address = true # Assign a public IP to this instance
  key_name                    = "master"
  tags = {
    Name = "web-server"
  }
  subnet_id     = aws_subnet.public_subnets.id
  security_groups = [aws_security_group.project-sg.name]
  //vpc_security_group_ids = [aws_security_group.project-sg.id]

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

resource "aws_subnet" "public_subnets" {
 count      = length(var.public_subnet_cidrs)
 vpc_id     = aws_vpc.project-vpc.id
 cidr_block = element(var.public_subnet_cidrs, count.index)
 availability_zone = element(var.azs, count.index)
 
 tags = {
   Name = "Public Subnet ${count.index + 1}"
 }
}

resource "aws_subnet" "private_subnets" {
 count      = length(var.private_subnet_cidrs)
 vpc_id     = aws_vpc.project-vpc.id
 cidr_block = element(var.private_subnet_cidrs, count.index)
 availability_zone = element(var.azs, count.index)
 
 tags = {
   Name = "Private Subnet ${count.index + 1}"
 }
}

resource "aws_internet_gateway" "project-gw" {
 vpc_id = aws_vpc.project-vpc.id
 
 tags = {
   Name = "project-gw"
 }
}

resource "aws_route_table" "second-rt" {
 vpc_id = aws_vpc.project-vpc.id
 
 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.project-gw.id
 }
 
 tags = {
   Name = "Second Route Table"
 }
}

resource "aws_route_table_association" "public_subnet_asso" {
 count = length(var.public_subnet_cidrs)
 subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
 route_table_id = aws_route_table.second-rt.id
}

resource "aws_security_group" "project-sg" {
  name        = "project-sg"
  description = "Example security group created with Terraform"

  vpc_id     = aws_vpc.project-vpc.id  # Update with your VPC ID

  // Ingress rules (incoming traffic)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH access from anywhere
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH access from anywhere
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]  # Allow HTTP access from anywhere
  }

  // Egress rules (outgoing traffic)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "instance-ip" {
  value = aws_instance.project.public_ip
}