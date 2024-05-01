provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "project1" {
  ami           = var.amis["20.04"]
  instance_type = var.instance_types[0]
  associate_public_ip_address = true  # Assign a public IP to this instance
  key_name      = "projects"
  tags = {
    Name = "web-server"
  }
security_groups = [var.security_groups["docker_sg"]]

connection {
    type        = "ssh"
    user        = "ubuntu"  # Update with appropriate username
    private_key = file("/home/ubuntu/.ssh/projects.pem")  # Path to your private key
    host        = self.public_ip  # Use the public IP of the instance
  }

provisioner "file" {
    source      = "/home/ubuntu/.ssh/ansible.pub"  # Path to your local public key
    destination = "/tmp/ansible.pub"  # Temporary location on the instance
  }

provisioner "remote-exec" {
    inline = [
     "sudo mkdir -p /home/ubuntu/.ssh",  # Create .ssh directory if it doesn't exist
      "sudo cp /tmp/ansible.pub /home/ubuntu/.ssh/authorized_keys",  # Copy public key to authorized_keys
      "sudo chown -R ubuntu:ubuntu /home/ubuntu/.ssh",  # Change ownership to ubuntu user
      "sudo chmod 600 /home/ubuntu/.ssh/authorized_keys"  # Set correct permissions on authorized_keys
    ]
  }

}
output "instance-ip" {
  value = aws_instance.project1.public_ip
}