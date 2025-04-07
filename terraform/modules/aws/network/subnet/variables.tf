variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnet_configs" {
  description = "List of subnet configurations"
  type = list(object({
    name              = string
    cidr_block        = string
    availability_zone = string
    is_public         = bool
  }))
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
} 