module "vpc" {
  source = "./vpc"
  providers = {
    ibm = ibm
  }
  name_prefix = var.name_prefix
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
  subnet_name = "${var.name_prefix}-${formatdate("YYYYMMDD", timestamp())}-subnet"
  region = var.region
  zone = var.zone
  vpc_cidr = cidrsubnet(var.vpc_cidr, 8, 1)  # Create a /24 subnet within the VPC CIDR
  resource_group_id = var.resource_group_id
  tags = var.tags

  depends_on = [module.vpc]
}

module "security_group" {
  source = "./security_group"
  providers = {
    ibm = ibm
  }
  vpc_id = module.vpc.vpc_id
  security_group_name = "${var.name_prefix}-${formatdate("YYYYMMDD", timestamp())}-sg"
  resource_group_id = var.resource_group_id
  rules = var.security_group_rules
  tags = var.tags

  depends_on = [module.vpc]
}

module "gateway" {
  count = var.create_public_gateway ? 1 : 0  # Make public gateway optional
  source = "./gateway"
  providers = {
    ibm = ibm
  }
  vpc_id = module.vpc.vpc_id
  gateway_name = "${var.name_prefix}-${formatdate("YYYYMMDD", timestamp())}-gateway"
  region = var.region
  zone = var.zone
  resource_group_id = var.resource_group_id
  tags = var.tags

  depends_on = [module.vpc]
}

module "route" {
  source = "./route"
  providers = {
    ibm = ibm
  }
  vpc_id = module.vpc.vpc_id
  routing_table_name = "${var.name_prefix}-${formatdate("YYYYMMDD", timestamp())}-route"
  region = var.region
  routes = var.routes

  depends_on = [module.vpc, module.gateway]
}

# Allow inbound SSH traffic
resource "ibm_is_security_group_rule" "allow_ssh" {
  group     = module.security_group.security_group_id
  direction = "inbound"
  remote    = "0.0.0.0/0"

  tcp {
    port_min = 22
    port_max = 22
  }
}

# Allow inbound ICMP (ping)
resource "ibm_is_security_group_rule" "allow_icmp" {
  group     = module.security_group.security_group_id
  direction = "inbound"
  remote    = "0.0.0.0/0"

  icmp {
    type = 8
    code = 0
  }
}

# Allow all outbound traffic
resource "ibm_is_security_group_rule" "allow_outbound" {
  group     = module.security_group.security_group_id
  direction = "outbound"
  remote    = "0.0.0.0/0"
} 