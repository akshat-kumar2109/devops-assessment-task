output "subnet_ids" {
  description = "List of subnet IDs"
  value       = aws_subnet.main[*].id
}

output "subnet_arns" {
  description = "List of subnet ARNs"
  value       = aws_subnet.main[*].arn
}

output "subnet_details" {
  description = "Map of subnet details"
  value = {
    for idx, subnet in aws_subnet.main : subnet.tags["Name"] => {
      id                = subnet.id
      arn               = subnet.arn
      cidr_block        = subnet.cidr_block
      availability_zone = subnet.availability_zone
      is_public         = var.subnet_configs[idx].is_public
    }
  }
}