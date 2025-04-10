output "vpc_id" {
  description = "ID of the created VPC"
  value       = ibm_is_vpc.vpc.id
}

output "vpc_crn" {
  description = "CRN of the created VPC"
  value       = ibm_is_vpc.vpc.crn
}

output "vpc_prefix_id" {
  description = "ID of the VPC address prefix"
  value       = ibm_is_vpc_address_prefix.vpc_prefix.id
} 