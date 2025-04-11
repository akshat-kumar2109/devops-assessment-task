# Create a namespace in IBM Container Registry
resource "ibm_cr_namespace" "container_registry_namespace" {
  name              = var.namespace_name
  resource_group_id = var.resource_group_id
}

# Create an IAM policy for the Container Registry
resource "ibm_iam_user_policy" "registry_policy" {
  count             = var.create_iam_policy ? 1 : 0
  ibm_id            = var.user_email
  roles             = var.registry_access_roles

  resources {
    service = "container-registry"
    region  = var.region
  }
}

# Optionally create retention policy
resource "ibm_cr_retention_policy" "retention_policy" {
  count         = var.enable_retention_policy ? 1 : 0
  namespace     = ibm_cr_namespace.container_registry_namespace.name
  images_per_repo = var.retention_images_per_repo
} 
