variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "region" {
  description = "IBM Cloud region"
  type        = string
}

variable "zone" {
  description = "IBM Cloud zone"
  type        = string
  default     = "us-east-1"
}

variable "resource_group_id" {
  description = "ID of the resource group"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "tags" {
  description = "List of tags to apply to all resources"
  type        = list(string)
  default     = []
} 