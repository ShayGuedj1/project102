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
    private_key = file("/home/ubuntu/.ssh/master.pem") # Path to your private key
    host        = self.public_ip                   # Use the public IP of the instance
    #agent        = true
  }

  provisioner "file" {
    source      = "/home/ubuntu/.ssh/id_rsa.pub" # Path to your local public key
    destination = "/tmp/id_rsa.pub"   # Temporary location on the instance
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p /home/ubuntu/.ssh",                            # Create .ssh directory if it doesn't exist
      "sudo cat /tmp/id_rsa.pub >> /home/ubuntu/.ssh/authorized_keys", # Copy public key to authorized_keys
      "sudo chown  ubuntu:ubuntu /home/ubuntu/.ssh",              # Change ownership to ubuntu user
      "sudo chmod 644 /home/ubuntu/.ssh/authorized_keys"            # Set correct permissions on authorized_keys
      
    ]
  }

}

output "instance-ip" {
  value = aws_instance.project1.public_ip
}