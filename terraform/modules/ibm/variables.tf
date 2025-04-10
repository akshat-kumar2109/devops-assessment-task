variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "project_name" {
  description = "Name of the project, used as a prefix for all resources"
  type        = string
}

variable "region" {
  description = "IBM Cloud region"
  type        = string
  default     = "us-east"
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

variable "instance_name" {
  description = "Name prefix for the VSI instances"
  type        = string
}

variable "public_key_path" {
  description = "Path to the public SSH key"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_ipv4_address_count" {
  description = "Number of IPv4 addresses for the subnet"
  type        = number
  default     = 256
}

variable "security_group_rules" {
  description = "Map of security group rules"
  type = map(object({
    direction  = string
    remote     = string
    protocol   = string
    port_min   = optional(number)
    port_max   = optional(number)
    icmp_type  = optional(number)
    icmp_code  = optional(number)
  }))
  default = {}
}

variable "routes" {
  description = "Map of routes to create"
  type = map(object({
    destination = string
    next_hop    = string
  }))
  default = {}
}

variable "monitoring_plan" {
  description = "Plan for the monitoring instance"
  type        = string
}

variable "alert_policies" {
  description = "Map of alert policies to create"
  type = map(object({
    description            = string
    severity              = string
    type                  = string
    enabled               = bool
    notification_channels = list(string)
    metric_conditions = list(object({
      metric     = string
      comparison = string
      threshold  = number
      duration   = string
    }))
  }))
  default = {}
}

variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 1
}

variable "instance_profile" {
  description = "Instance profile to use for the VSI"
  type        = string
  default     = "bx2-2x8"
}

variable "image_id" {
  description = "ID of the image to use for the VSI"
  type        = string
  default     = ""
}

variable "user_data" {
  description = "User data to inject into the instance"
  type        = string
  default     = ""
}

variable "boot_volume_size" {
  description = "Size of the boot volume in GB"
  type        = number
  default     = 100
}

variable "create_floating_ip" {
  description = "Whether to create a floating IP for the instance"
  type        = bool
  default     = false
}

variable "tags" {
  description = "List of tags to apply to all resources"
  type        = list(string)
  default     = []
}
