resource "ibm_is_subnet" "subnet" {
  name                     = var.subnet_name
  vpc                      = var.vpc_id
  zone                     = var.zone
  total_ipv4_address_count = var.ipv4_address_count
  resource_group          = var.resource_group_id
  tags                    = var.tags
} 