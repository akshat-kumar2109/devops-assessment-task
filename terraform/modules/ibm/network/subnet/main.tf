resource "ibm_is_subnet" "subnet" {
  name            = var.subnet_name
  vpc             = var.vpc_id
  zone            = var.zone
  ipv4_cidr_block = var.vpc_cidr
  resource_group  = var.resource_group_id
  tags            = var.tags
} 