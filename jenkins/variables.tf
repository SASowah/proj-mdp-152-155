variable "aws_region" {
  description = "The AWS region to deploy the Jenkins instance."
  default     = "us-east-1"
  
}

variable "key_name" {
  description = "The name of the key pair to use for SSH access to the Jenkins instance."
  default     = "devkey"
  
}

variable "subnet_id" {
  description = "The ID of the subnet to launch the Jenkins instance in."
  default     = "public_devops_subnet_a"
  
}