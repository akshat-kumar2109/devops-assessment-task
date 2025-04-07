variable "vpc_name" {
  description = "The name tag to assign to the VPC"
  type        = string
  default     = "social-vpc"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "project_name" {
  description = "Name of the project, used as a prefix for all resources"
  type        = string
  default     = "social-app"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}
