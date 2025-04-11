resource "ibm_is_vpc" "vpc" {
  name           = "${var.name_prefix}-vpc"
  resource_group = var.resource_group_id
  tags           = var.tags
}

resource "ibm_is_vpc_address_prefix" "vpc_prefix" {
  name = "${var.name_prefix}-prefix"
  zone = var.zone
  vpc  = ibm_is_vpc.vpc.id
  cidr = var.vpc_cidr
} 