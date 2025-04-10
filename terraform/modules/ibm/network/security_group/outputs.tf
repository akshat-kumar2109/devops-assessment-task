output "security_group_id" {
  description = "ID of the created security group"
  value       = ibm_is_security_group.security_group.id
}

output "security_group_crn" {
  description = "CRN of the created security group"
  value       = ibm_is_security_group.security_group.crn
} 