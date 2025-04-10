output "instance_ids" {
  description = "List of instance IDs"
  value       = ibm_is_instance.instance[*].id
}

output "instance_ips" {
  description = "List of instance private IPs"
  value       = ibm_is_instance.instance[*].primary_network_interface[0].primary_ipv4_address
}

output "floating_ips" {
  description = "List of floating IPs"
  value       = ibm_is_floating_ip.floating_ip[*].address
} 