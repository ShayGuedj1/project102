variable "instance_types" {
  description = "List of instance types to deploy"
  type        = list(string)
  default     = ["t2.micro", "t2.small", "t2.medium"]
}

#variable "instance_count" {
#  description = "Number of EC2 instances to create"
#  type        = number
#}

variable "amis" {
  description = "List of amis ubuntu types to deploy"
  type        = map(string)
  default = {
    22.04 = "ami-080e1f13689e07408",
    20.04 = "ami-0cd59ecaf368e5ccf"

  }
}

variable "security_groups" {
  type = map(string)
  default = {
    docker_sg  = "docker -sg"
    jenkins_sg = "sg-1234567"
    ansible_sg = "sg-654321"
  }
}