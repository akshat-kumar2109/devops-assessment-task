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
  tags           = [
    "Environment:${var.environment}",
    "Project:${var.project_name}",
    "Terraform:true"
  ]
}