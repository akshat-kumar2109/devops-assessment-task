terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.94.1"
    }
    ibm = {
      source = "ibm-cloud/ibm"
      version = "1.77.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  
  # If you're using assume role, uncomment and configure these:
  assume_role {
    role_arn = "arn:aws:iam::654654269997:role/terraform-role"
  }
}

provider "aws" {
  alias  = "aws"
  region = "us-east-1"
  
  # If you're using assume role, uncomment and configure these:
  assume_role {
    role_arn = "arn:aws:iam::654654269997:role/terraform-role"
  }
}

# Main IBM provider for VPC, Compute, and other services
provider "ibm" {
  alias = "ibm"
  region = "us-east"
  zone = "us-east-1"
  ibmcloud_api_key = var.ibmcloud_api_key
  iaas_classic_username = var.iaas_classic_username
  iaas_classic_api_key = var.iaas_classic_api_key
  resource_group = var.resource_group
}

# Separate provider for Container Registry
provider "ibm" {
  alias = "ibm_cr"
  region = "global"
  ibmcloud_api_key = var.ibmcloud_api_key
  iaas_classic_username = var.iaas_classic_username
  iaas_classic_api_key = var.iaas_classic_api_key
  resource_group = var.resource_group
}

# Separate provider for Logging service
provider "ibm" {
  alias = "ibm_log"
  region = "us-east"
  ibmcloud_api_key = var.ibmcloud_api_key
  iaas_classic_username = var.iaas_classic_username
  iaas_classic_api_key = var.iaas_classic_api_key
  resource_group = var.resource_group
}