output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.main.id
}

output "internet_gateway_arn" {
  description = "ARN of the Internet Gateway"
  value       = aws_internet_gateway.main.arn
}

# output "nat_gateway_ids" {
#   description = "IDs of the NAT Gateways"
#   value       = aws_nat_gateway.main[*].id
# }

# output "nat_gateway_public_ips" {
#   description = "Public IPs of the NAT Gateways"
#   value       = aws_nat_gateway.main[*].public_ip
# }

# output "nat_gateway_private_ips" {
#   description = "Private IPs of the NAT Gateways"
#   value       = aws_nat_gateway.main[*].private_ip
# }

# output "eip_ids" {
#   description = "IDs of the Elastic IPs"
#   value       = aws_eip.nat[*].id
# }

# output "eip_public_ips" {
#   description = "Public IPs of the Elastic IPs"
#   value       = aws_eip.nat[*].public_ip
# } 