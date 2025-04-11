output "instance_ids" {
  description = "IDs of created instances"
  value       = ibm_is_instance.instance[*].id
}

output "instance_private_ips" {
  description = "Private IP addresses of created instances"
  value       = [for instance in ibm_is_instance.instance : instance.primary_network_interface[0].primary_ipv4_address]
}

output "instance_public_ips" {
  description = "Public IP addresses of created instances (if floating IPs were created)"
  value       = var.create_floating_ip ? ibm_is_floating_ip.floating_ip[*].address : []
}

output "floating_ip_ids" {
  description = "IDs of created floating IPs"
  value       = var.create_floating_ip ? ibm_is_floating_ip.floating_ip[*].id : []
} 