variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "gateway_name" {
  description = "Name of the Internet Gateway"
  type        = string
}

variable "create_nat_gateway" {
  description = "Whether to create NAT Gateway"
  type        = bool
  default     = false
}

variable "public_subnet_id" {
  description = "ID of the public subnet where NAT Gateway will be created"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
} 