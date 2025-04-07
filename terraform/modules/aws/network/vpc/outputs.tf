output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "vpc_arn" {
  description = "ARN of the VPC"
  value       = aws_vpc.main.arn
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "default_security_group_id" {
  description = "ID of the VPC's default security group"
  value       = aws_vpc.main.default_security_group_id
}

output "default_network_acl_id" {
  description = "ID of the VPC's default network ACL"
  value       = aws_vpc.main.default_network_acl_id
}

output "default_route_table_id" {
  description = "ID of the VPC's default route table"
  value       = aws_vpc.main.default_route_table_id
}

output "dhcp_options_id" {
  description = "ID of DHCP options set"
  value       = aws_vpc_dhcp_options.main.id
} 