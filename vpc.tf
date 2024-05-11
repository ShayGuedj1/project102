resource "aws_vpc" "project-vpc" {
  cidr_block       = "10.0.0.0/16"  # Define the IP range for your VPC
  instance_tenancy = "default"      # Set the instance tenancy (default or dedicated)
  
  tags = {
    Name = "project-vpc"  # Optional: Set a name tag for your VPC
  }
}