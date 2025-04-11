# output "instance_id" {
#   description = "ID of the EC2 instance"
#   value       = aws_instance.web.id
# }

# output "instance_public_ip" {
#   description = "Public IP address of the EC2 instance"
#   value       = aws_instance.web.public_ip
# }

# output "instance_private_ip" {
#   description = "Private IP address of the EC2 instance"
#   value       = aws_instance.web.private_ip
# }

# output "instance_arn" {
#   description = "ARN of the EC2 instance"
#   value       = aws_instance.web.arn
# }

output "instance_ids" {
  description = "IDs of the EC2 instances"
  value       = [for instance in aws_instance.web : instance.id]
}

output "instance_public_ips" {
  description = "Public IP addresses of the EC2 instances"
  value       = [for instance in aws_instance.web : instance.public_ip]
}

output "instance_private_ips" {
  description = "Private IP addresses of the EC2 instances"
  value       = [for instance in aws_instance.web : instance.private_ip]
}

output "instance_arns" {
  description = "ARNs of the EC2 instances"
  value       = [for instance in aws_instance.web : instance.arn]
}
