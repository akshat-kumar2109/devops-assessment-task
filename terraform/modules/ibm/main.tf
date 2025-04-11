module "network" {
  source = "./network"
  providers = {
    ibm = ibm
  }
  
  name_prefix      = var.vpc_name
  region           = var.region
  zone             = var.zone
  resource_group_id = var.resource_group_id
  vpc_cidr         = var.vpc_cidr
  subnet_ipv4_address_count = var.subnet_ipv4_address_count
  security_group_rules = var.security_group_rules
  routes            = var.routes
  tags              = var.tags
}

# module "monitoring" {
#   source = "./monitoring"
#   providers = {
#     ibm = ibm
#     ibm.ibm_log = ibm.ibm_log
#   }
  
#   project_name = var.project_name
#   monitoring_instance_name = "${var.project_name}-monitoring"
#   monitoring_plan         = var.monitoring_plan
#   region                 = var.region
#   resource_group_id      = var.resource_group_id
#   alert_policies         = var.alert_policies
#   tags                   = var.tags
# }

module "registry" {
  source = "./registry"
  providers = {
    ibm = ibm.ibm_cr
  }
  
  project_name = var.project_name
  region       = var.region
  resource_group_id = var.resource_group_id
  tags         = var.tags
}

module "compute" {
  source = "./compute"
  providers = {
    ibm = ibm
  }
  
  name_prefix       = var.instance_name
  instance_count    = var.instance_count
  vpc_id            = module.network.vpc_id
  zone              = "${var.region}-1"
  instance_profile  = var.instance_profile
  image_id          = var.image_id
  ssh_key_ids       = [ibm_is_ssh_key.deployer.id]
  resource_group_id = var.resource_group_id
  subnet_id         = module.network.subnet_id
  security_group_ids = [module.network.security_group_id]
  boot_volume_size  = var.boot_volume_size
  create_floating_ip = var.create_floating_ip
  tags              = var.tags

  depends_on = [module.network]
}

# Create SSH Key
resource "ibm_is_ssh_key" "deployer" {
  name           = "${var.project_name}-ssh-key"
  public_key     = file(var.public_key_path)
  resource_group = var.resource_group_id
  tags           = var.tags
}
