variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "security_group_name" {
  description = "Name of the security group"
  type        = string
}

variable "ingress_rules" {
  description = "List of ingress rules"
  type = list(object({
    cidr_blocks = string
    protocol    = string
    from_port   = number
    to_port     = number
    description = string
  }))
}

variable "egress_rules" {
  description = "List of egress rules"
  type = list(object({
    cidr_blocks = string
    protocol    = string
    from_port   = number
    to_port     = number
    description = string
  }))

  default = [{
    cidr_blocks = "0.0.0.0/0"
    protocol    = -1
    from_port   = null
    to_port     = null
    description = "Allow all outbound"
  }]
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}