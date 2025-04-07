output "security_group_id" {
  value = module.security_group.security_group_id
}

output "subnet_ids" {
  value = module.subnet.subnet_ids
}

output "vpc_id" {
  value = module.vpc.vpc_id
}