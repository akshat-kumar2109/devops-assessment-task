# Terraform Infrastructure

## Directory Structure

```
terraform/
├── main.tf                    # Main infrastructure configuration
├── variables.tf               # Input variables definition
├── outputs.tf                 # Output variables definition
├── providers.tf               # Provider configuration
├── backend.tf                # Backend configuration (empty)
├── terraform.tfvars.template # Template for variables
├── deployer-key              # SSH private key for deployment
├── deployer-key.pub          # SSH public key for deployment
├── modules/
│   ├── aws/
│   │   ├── compute/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   ├── ecr/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   ├── monitoring/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   └── network/
│   │       ├── main.tf
│   │       ├── variables.tf
│   │       └── outputs.tf
│   └── ibm/
│       ├── compute/
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   └── outputs.tf
│       ├── network/
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   └── outputs.tf
│       └── registry/
│           ├── main.tf
│           ├── variables.tf
│           └── outputs.tf
└── README.md                # This documentation
```

## Configuration

### Setting up Variables

1. Copy the template file:
   ```bash
   cp terraform.tfvars.template terraform.tfvars
   ```

2. Edit `terraform.tfvars` with your values:
   ```hcl
   aws_region = "us-east-1"  # Default 
   vpc_name = "social-vpc"   # Default
   vpc_cidr = "10.0.0.0/16"  # Default
   project_name = "social-app"  # Default
   environment = "production"  # Default
   ibm_region = "us-east"  # Default
   ibm_zone = "us-east-1"  # Default
   ibm_resource_group_id = ""
   ibm_instance_name = "social-instance"  # Default
   monitoring_plan = "lite"  # Default
   ibmcloud_api_key = ""
   iaas_classic_username = ""
   iaas_classic_api_key = ""
   resource_group = ""
   ```

## Prerequisites

1. Install Terraform
2. Configure AWS CLI with credentials
3. Configure IBM Cloud CLI with credentials

## Usage

1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Plan the changes:
   ```bash
   terraform plan
   ```

3. Apply the changes:
   ```bash
   terraform apply
   ```

4. To destroy the infrastructure:
   ```bash
   terraform destroy
   ```

## Outputs

- `aws_instance_ips`: Public IPs of AWS EC2 instance
- `ibm_instance_ip`: Public IP of IBM Cloud instance
- `monitoring_server_ip`: Public IP of monitoring server

## Resources Created

### AWS Resources
- EC2 instance for application
- Security groups
- CloudWatch alarms
- ECR repository

### IBM Cloud Resources
- Virtual server instance
- Security groups
- Container Registry namespace

### Monitoring Resources
- EC2 instance for Grafana/Prometheus
- Security groups for monitoring

## Notes

- The state files are stored locally. For production, consider using remote state storage.
- Sensitive information should be managed through variables and not committed to version control.
- The deployer key pair is used for GitHub Actions deployment. 