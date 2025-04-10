variable "security_group_name" {
  description = "Name of the security group"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "resource_group_id" {
  description = "ID of the resource group"
  type        = string
}

variable "rules" {
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

variable "tags" {
  description = "List of tags to apply to all resources"
  type        = list(string)
  default     = []
} 