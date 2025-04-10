variable "routing_table_name" {
  description = "Name of the routing table"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "region" {
  description = "IBM Cloud region"
  type        = string
}

variable "routes" {
  description = "Map of routes to create"
  type = map(object({
    destination = string
    next_hop    = string
  }))
  default = {}
} 