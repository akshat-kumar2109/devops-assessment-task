output "vpc_id" {
  description = "ID of the VPC"
  value       = module.network.vpc_id
}

output "vpc_crn" {
  description = "CRN of the created VPC"
  value       = module.network.vpc_crn
}

output "subnet_id" {
  description = "ID of the subnet"
  value       = module.network.subnet_id
}

output "subnet_crn" {
  description = "CRN of the created subnet"
  value       = module.network.subnet_crn
}

output "subnet_cidr" {
  description = "CIDR block of the created subnet"
  value       = module.network.subnet_cidr
}

output "security_group_id" {
  description = "ID of the security group"
  value       = module.network.security_group_id
}

output "security_group_crn" {
  description = "CRN of the created security group"
  value       = module.network.security_group_crn
}

output "gateway_id" {
  description = "ID of the created public gateway"
  value       = module.network.gateway_id
}

output "gateway_crn" {
  description = "CRN of the created public gateway"
  value       = module.network.gateway_crn
}

output "routing_table_id" {
  description = "ID of the created routing table"
  value       = module.network.routing_table_id
}

output "route_ids" {
  description = "Map of route IDs"
  value       = module.network.route_ids
}

output "instance_ids" {
  description = "List of instance IDs"
  value       = module.compute.instance_ids
}

output "instance_private_ips" {
  description = "Private IP addresses of created instances"
  value       = module.compute.instance_private_ips
}

output "instance_public_ips" {
  description = "Public IP addresses of created instances (if floating IPs were created)"
  value       = module.compute.instance_public_ips
}

output "floating_ip_ids" {
  description = "IDs of created floating IPs"
  value       = module.compute.floating_ip_ids
}

# output "monitoring_instance_id" {
#   description = "ID of the monitoring instance"
#   value       = module.monitoring.monitoring_instance_id
# }

# output "monitoring_instance_guid" {
#   description = "GUID of the monitoring instance"
#   value       = module.monitoring.monitoring_instance_guid
# }

# output "monitoring_key" {
#   description = "Credentials for the monitoring instance"
#   value       = module.monitoring.monitoring_key
#   sensitive   = true
# }

# output "logging_instance_id" {
#   description = "ID of the logging instance"
#   value       = module.monitoring.logging_instance_id
# }

# output "logging_instance_guid" {
#   description = "GUID of the logging instance"
#   value       = module.monitoring.logging_instance_guid
# }

# output "logging_key" {
#   description = "Credentials for the logging instance"
#   value       = module.monitoring.logging_key
#   sensitive   = true
# }

output "ssh_key_id" {
  description = "ID of the created SSH key"
  value       = ibm_is_ssh_key.deployer.id
}

output "registry_url" {
  description = "URL of the container registry"
  value       = module.registry.registry_url
}
