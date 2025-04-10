output "vpc_id" {
  description = "ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "vpc_crn" {
  description = "CRN of the created VPC"
  value       = module.vpc.vpc_crn
}

output "subnet_id" {
  description = "ID of the created subnet"
  value       = module.subnet.subnet_id
}

output "subnet_crn" {
  description = "CRN of the created subnet"
  value       = module.subnet.subnet_crn
}

output "subnet_cidr" {
  description = "CIDR block of the created subnet"
  value       = module.subnet.subnet_cidr
}

output "security_group_id" {
  description = "ID of the created security group"
  value       = module.security_group.security_group_id
}

output "security_group_crn" {
  description = "CRN of the created security group"
  value       = module.security_group.security_group_crn
}

output "gateway_id" {
  description = "ID of the created public gateway"
  value       = module.gateway.gateway_id
}

output "gateway_crn" {
  description = "CRN of the created public gateway"
  value       = module.gateway.gateway_crn
}

output "routing_table_id" {
  description = "ID of the created routing table"
  value       = module.route.routing_table_id
}

output "route_ids" {
  description = "Map of route IDs"
  value       = module.route.route_ids
} 