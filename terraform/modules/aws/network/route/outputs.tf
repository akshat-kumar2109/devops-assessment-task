output "route_table_ids" {
  description = "IDs of the route tables"
  value       = aws_route_table.main[*].id
}

output "route_table_arns" {
  description = "ARNs of the route tables"
  value       = aws_route_table.main[*].arn
}

output "route_table_associations" {
  description = "List of route table associations"
  value       = aws_route_table_association.main[*].id
}

output "route_table_details" {
  description = "Map of route table details"
  value = {
    for idx, rt in aws_route_table.main : rt.tags["Name"] => {
      id     = rt.id
      arn    = rt.arn
      routes = rt.route
    }
  }
} 