module "aws" {
  source          = "./modules/aws"
  providers = {
    aws = aws.aws
  }
  vpc_name        = var.vpc_name
  vpc_cidr        = var.vpc_cidr
  project_name    = var.project_name
  public_key_path = "${path.module}/deployer-key.pub"
  tags = {
    Environment = var.environment
    Project     = var.project_name
    Terraform   = "true"
  }
}

module "ibm" {
  source          = "./modules/ibm"
  providers = {
    ibm = ibm.ibm
    ibm.ibm_cr = ibm.ibm_cr
    ibm.ibm_log = ibm.ibm_log
  }
  vpc_name        = var.vpc_name
  vpc_cidr        = var.vpc_cidr
  project_name    = var.project_name
  public_key_path = "${path.module}/deployer-key.pub"  # Using the same deployer key as AWS
  region          = var.ibm_region
  zone            = var.ibm_zone
  monitoring_plan = var.monitoring_plan
  resource_group_id = var.ibm_resource_group_id
  instance_name   = var.ibm_instance_name
  security_group_rules = {
    ssh = {
      direction = "inbound"
      remote    = "0.0.0.0/0"
      protocol  = "tcp"
      port_min  = 22
      port_max  = 22
    },
    http = {
      direction = "inbound"
      remote    = "0.0.0.0/0"
      protocol  = "tcp"
      port_min  = 80
      port_max  = 80
    },
    grafana = {
      direction = "inbound"
      remote    = "0.0.0.0/0"
      protocol  = "tcp"
      port_min  = 3000
      port_max  = 3000
    },
    prometheus = {
      direction = "inbound"
      remote    = "0.0.0.0/0"
      protocol  = "tcp"
      port_min  = 9090
      port_max  = 9090
    },
    loki = {
      direction = "inbound"
      remote    = "0.0.0.0/0"
      protocol  = "tcp"
      port_min  = 3100
      port_max  = 3100
    },
    node_exporter = {
      direction = "inbound"
      remote    = "0.0.0.0/0"
      protocol  = "tcp"
      port_min  = 9100
      port_max  = 9100
    },
    promtail = {
      direction = "inbound"
      remote    = "0.0.0.0/0"
      protocol  = "tcp"
      port_min  = 9080
      port_max  = 9080
    },
    app_port = {
      direction = "inbound"
      remote    = "0.0.0.0/0"
      protocol  = "tcp"
      port_min  = 5000
      port_max  = 5000
    }
  }
  tags           = [
    "Environment:${var.environment}",
    "Project:${var.project_name}",
    "Terraform:true"
  ]
}