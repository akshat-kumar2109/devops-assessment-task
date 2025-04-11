output "namespace_id" {
  description = "ID of the created container registry namespace"
  value       = ibm_cr_namespace.container_registry_namespace.id
}

output "namespace_name" {
  description = "Name of the created container registry namespace"
  value       = ibm_cr_namespace.container_registry_namespace.name
}

output "registry_url" {
  description = "URL of the container registry"
  value       = "${var.region}.icr.io/${ibm_cr_namespace.container_registry_namespace.name}"
}