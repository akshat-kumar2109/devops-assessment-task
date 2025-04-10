output "gateway_id" {
  description = "ID of the created public gateway"
  value       = ibm_is_public_gateway.gateway.id
}

output "gateway_crn" {
  description = "CRN of the created public gateway"
  value       = ibm_is_public_gateway.gateway.crn
} 