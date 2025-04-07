output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.main.id
}

output "security_group_arn" {
  description = "ARN of the security group"
  value       = aws_security_group.main.arn
}

output "security_group_name" {
  description = "Name of the security group"
  value       = aws_security_group.main.name
}

output "security_group_description" {
  description = "Description of the security group"
  value       = aws_security_group.main.description
}

output "security_group_ingress_rules" {
  description = "List of ingress rules"
  value       = aws_security_group.main.ingress
}

output "security_group_egress_rules" {
  description = "List of egress rules"
  value       = aws_security_group.main.egress
} 