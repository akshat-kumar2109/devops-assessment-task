resource "ibm_is_public_gateway" "gateway" {
  name           = var.gateway_name
  vpc            = var.vpc_id
  zone           = var.zone
  resource_group = var.resource_group_id
  tags           = var.tags
} 