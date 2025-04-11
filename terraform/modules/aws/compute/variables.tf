variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}

variable "public_key" {
  description = "Public key material for SSH key pair"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet to launch the instance in"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "security_group_id" {
  description = "ID of the security group for the instance"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone to launch the instance in"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "cloudwatch_agent_profile_name" {
  description = "Name of the IAM instance profile for CloudWatch agent"
  type        = string
}

variable "cloudwatch_config" {
  description = "SSM parameter name containing CloudWatch agent configuration"
  type        = string
}

variable "instance_count" {
  description = "Number of instance to be created"
  default = 2
}