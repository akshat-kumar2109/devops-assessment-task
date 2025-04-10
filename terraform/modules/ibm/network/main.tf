module "vpc" {
  source = "./vpc"
  providers = {
    ibm = ibm
  }
  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr
  region = var.region
  zone = var.zone
  resource_group_id = var.resource_group_id
  tags = var.tags
}

module "subnet" {
  source = "./subnet"
  providers = {
    ibm = ibm
  }
  vpc_id = module.vpc.vpc_id
  subnet_name = "${var.vpc_name}-subnet"
  region = var.region
  zone = var.zone
  ipv4_address_count = var.subnet_ipv4_address_count
  resource_group_id = var.resource_group_id
  tags = var.tags
}

module "security_group" {
  source = "./security_group"
  providers = {
    ibm = ibm
  }
  vpc_id = module.vpc.vpc_id
  security_group_name = "${var.vpc_name}-sg"
  resource_group_id = var.resource_group_id
  rules = var.security_group_rules
  tags = var.tags
}

module "gateway" {
  source = "./gateway"
  providers = {
    ibm = ibm
  }
  vpc_id = module.vpc.vpc_id
  gateway_name = "${var.vpc_name}-gateway"
  region = var.region
  zone = var.zone
  resource_group_id = var.resource_group_id
  tags = var.tags
}

module "route" {
  source = "./route"
  providers = {
    ibm = ibm
  }
  vpc_id = module.vpc.vpc_id
  routing_table_name = "${var.vpc_name}-route"
  region = var.region
  routes = var.routes
} 