output "routing_table_id" {
  description = "ID of the created routing table"
  value       = ibm_is_vpc_routing_table.routing_table.id
}

output "route_ids" {
  description = "Map of route IDs"
  value       = { for k, v in ibm_is_vpc_routing_table_route.routes : k => v.id }
} 