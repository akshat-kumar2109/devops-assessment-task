module "aws" {
  source          = "./modules/aws"
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