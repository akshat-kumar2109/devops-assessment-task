module "network" {
  source = "./network"
  providers = {
    aws = aws
  }
}

module "monitoring" {
  source = "./monitoring"
  providers = {
    aws = aws
  }
  project_name = var.project_name
  tags = var.tags
}

module "ecr" {
  source = "./ecr"
  providers = {
    aws = aws
  }
  repository_name = "${var.project_name}-app"
  tags = var.tags
}

module "compute" {
  source = "./compute"
  providers = {
    aws = aws
  }
  availability_zone = "us-east-1a"
  instance_name = "social-instance"
  key_name = "deployer-key"
  public_key = file(var.public_key_path)
  security_group_id = module.network.security_group_id
  subnet_id = module.network.subnet_ids[0]
  vpc_id = module.network.vpc_id
  tags = var.tags
  cloudwatch_agent_profile_name = module.monitoring.cloudwatch_agent_profile_name
  cloudwatch_config = module.monitoring.cloudwatch_config_parameter_name

  depends_on = [ module.network, module.monitoring ]
}