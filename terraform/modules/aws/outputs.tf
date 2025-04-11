output "instance_ids" {
  value = module.compute.instance_ids
}

output "instance_public_ips" {
  value = module.compute.instance_public_ips
}

output "instance_private_ips" {
  value = module.compute.instance_private_ips
}

output "instance_arns" {
  value = module.compute.instance_arns
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.network.vpc_id
}

output "subnet_ids" {
  description = "IDs of the subnets"
  value       = module.network.subnet_ids
}

output "ecr_repository_url" {
  description = "URL of the ECR repository"
  value       = module.ecr.repository_url
}

output "ecr_repository_name" {
  description = "Name of the ECR repository"
  value       = module.ecr.repository_name
}
