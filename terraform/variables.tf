variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment (e.g., dev, staging, prod)"
  type        = string
  default     = "production"
}

variable "ibm_region" {
  description = "IBM Cloud region"
  type        = string
  default     = "us-east"
}

variable "ibm_resource_group_id" {
  description = "ID of the IBM resource group"
  type        = string
}

variable "ibm_instance_name" {
  description = "Name prefix for IBM VSI instances"
  type        = string
  default     = "social-instance"
}

variable "monitoring_plan" {
  description = "IBM Cloud Monitoring plan"
  type        = string
  default     = "lite"
}

variable "ibm_zone" {
  description = "IBM Cloud zone"
  type        = string
  default     = "us-east-1"
}

variable "ibmcloud_api_key" {
  
}

variable "iaas_classic_username" {
  
}

variable "iaas_classic_api_key" {
  
}

variable "resource_group" {
  
}
