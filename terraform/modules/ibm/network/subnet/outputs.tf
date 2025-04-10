output "subnet_id" {
  description = "ID of the created subnet"
  value       = ibm_is_subnet.subnet.id
}

output "subnet_crn" {
  description = "CRN of the created subnet"
  value       = ibm_is_subnet.subnet.crn
}

output "subnet_cidr" {
  description = "CIDR block of the created subnet"
  value       = ibm_is_subnet.subnet.ipv4_cidr_block
}

output "subnet_zone" {
  description = "Zone of the created subnet"
  value       = ibm_is_subnet.subnet.zone
} 