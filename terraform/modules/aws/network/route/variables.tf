variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "route_tables" {
  type = list(object({
    name       = string
    subnet_ids = list(string)
    routes     = list(object({
      cidr_block                = string
      gateway_id                = optional(string)
      nat_gateway_id            = optional(string)
      network_interface_id      = optional(string)
      vpc_peering_connection_id = optional(string)
    }))
  }))
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
} 