variable "instance_types" {
  description = "List of instance types to deploy"
  type        = list(string)
  default     = ["t2.micro", "t2.small", "t2.medium"]
}

variable "amis" {
  description = "List of amis ubuntu types to deploy"
  type        = map(string)
  default = {
    22.04 = "ami-080e1f13689e07408",
    20.04 = "ami-0cd59ecaf368e5ccf"

  }
}

variable "public_subnet_cidrs" {
 type        = list(string)
 description = "Public Subnet CIDR values"
 default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}
 
variable "private_subnet_cidrs" {
 type        = list(string)
 description = "Private Subnet CIDR values"
 default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "azs" {
 type        = list(string)
 description = "Availability Zones"
 default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

/*variable "security_groups" {
  type = map(string)
  default = {
    docker_sg  = "docker -sg"
    jenkins_sg = "sg-1234567"
    ansible_sg = "sg-654321"
  }
}*/