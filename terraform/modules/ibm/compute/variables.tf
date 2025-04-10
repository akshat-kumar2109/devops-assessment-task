variable "name_prefix" {
  description = "Prefix to be used for resource names"
  type        = string
}

variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 1
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "zone" {
  description = "Zone where the instance will be created"
  type        = string
}

variable "instance_profile" {
  description = "Instance profile to use for the VSI"
  type        = string
  default     = "bx2-2x8"
}

variable "image_id" {
  description = "ID of the image to use for the VSI"
  type        = string
}

variable "ssh_key_ids" {
  description = "List of SSH key IDs to inject into the instance"
  type        = list(string)
}

variable "resource_group_id" {
  description = "ID of the resource group"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet to attach the instance to"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to attach to the instance"
  type        = list(string)
}

variable "boot_volume_size" {
  description = "Size of the boot volume in GB"
  type        = number
  default     = 100
}

variable "create_floating_ip" {
  description = "Whether to create a floating IP for the instance"
  type        = bool
  default     = true
}

variable "tags" {
  description = "List of tags to apply to all resources"
  type        = list(string)
  default     = []
} 