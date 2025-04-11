variable "region" {
  description = "IBM Cloud region"
  type        = string
}

variable "zone" {
  description = "IBM Cloud zone where resources will be created"
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

variable "name_prefix" {
  description = "Prefix to be used for resource names"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "tags" {
  description = "List of tags to apply to all resources"
  type        = list(string)
  default     = []
}

variable "create_public_gateway" {
  description = "Whether to create a public gateway. Set to false if you've reached the quota limit."
  type        = bool
  default     = false  # Default to false since there's a quota of 1 per zone
} 