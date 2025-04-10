# Create Container Registry namespace only
# The retention policy will be managed separately after namespace creation
resource "ibm_cr_namespace" "registry" {
  name              = lower(replace(var.project_name, "/[^a-z0-9]/", ""))
  resource_group_id = var.resource_group_id
} 

# # Create Registry retention policy - Commented out until namespace is created
# resource "ibm_cr_retention_policy" "policy" {
#   namespace        = ibm_cr_namespace.registry.name
#   images_per_repo  = 5
# } 