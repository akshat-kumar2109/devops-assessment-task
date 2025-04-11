output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.aws.vpc_id
}

output "aws_instance_public_ip" {
  value = module.aws.instance_public_ips
}

output "ibm_instance_public_ip" {
  value = module.ibm.instance_public_ips
}
