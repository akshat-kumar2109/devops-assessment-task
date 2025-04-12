# DevOps Engineer Assessment Task

## Configuration Management

### Sensitive Files
The following files contain sensitive information and should not be committed to Git:

1. **Terraform Variables (`terraform/terraform.tfvars`)**
   - Contains cloud provider credentials and configuration
   - Use `terraform.tfvars.template` as a base
   - Never commit actual credentials

2. **Ansible Inventory (`ansible/inventory.ini`)**
   - Contains server IP addresses
   - Use `inventory.ini.template` as a base
   - Never commit actual IP addresses

### Setting Up Configuration Files

1. **For Terraform:**
   ```bash
   cp terraform/terraform.tfvars.template terraform/terraform.tfvars
   ```
   Then edit `terraform.tfvars` with your values:
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

2. **For Ansible:**
   ```bash
   cp ansible/inventory.ini.template ansible/inventory.ini
   ```
   ```ini
   # Monitoring server
   [monitoring]
   monitor.example.com ansible_host=<MONITORING_SERVER_IP> ansible_user=ubuntu  # Replace with actual monitoring server IP

   # Nodes servers
   [nodes]
   aws-node ansible_host=<AWS_INSTANCE_IP> ansible_user=ubuntu     # Replace with actual AWS EC2 instance IP
   ibm-node ansible_host=<IBM_INSTANCE_IP> ansible_user=ubuntu     # Replace with actual IBM Cloud instance IP

   [all_nodes:children]
   monitoring
   nodes
   ```

### Security Notes

- Never commit files containing:
  - Cloud provider credentials
  - API keys
  - Server IP addresses
  - SSH private keys
  - Resource IDs

- Add these files to `.gitignore`:
  ```
  # Terraform
  terraform.tfvars
  *.tfstate
  *.tfstate.*
  .terraform/

  # Ansible
  inventory.ini
  group_vars/all.yml
  ```

## Directory Structure
```
.
├── .github/
│   └── workflows/
│       └── deploy.yml          # GitHub Actions workflow
├── ansible/
│   ├── group_vars/
│   │   └── all.yml            # Global variables
│   ├── roles/
│   │   ├── common/            # Common configurations
│   │   ├── grafana/
│   │   │   ├── files/
│   │   │   │   ├── system-logs-dashboard.json
│   │   │   │   └── grafana.ini
│   │   │   └── tasks/
│   │   │       └── main.yml
│   │   ├── loki/
│   │   │   ├── files/
│   │   │   │   └── loki-config.yml
│   │   │   └── tasks/
│   │   │       └── main.yml
│   │   ├── node_exporter/
│   │   │   └── tasks/
│   │   │       └── main.yml
│   │   └── promtail/
│   │       └── tasks/
│   │           └── main.yml
│   ├── inventory.ini           # Inventory file
│   ├── site.yml               # Main playbook
│   └── README.md
├── node-app/
│   ├── src/
│   │   ├── index.js           # Main application file
│   │   └── routes/            # API routes
│   ├── Dockerfile             # Container configuration
│   ├── package.json           # Dependencies and scripts
│   └── README.md
├── terraform/
│   ├── modules/
│   │   ├── aws/
│   │   │   ├── compute/
│   │   │   ├── ecr/
│   │   │   ├── monitoring/
│   │   │   └── network/
│   │   └── ibm/
│   │       ├── compute/
│   │       ├── network/
│   │       └── registry/
│   ├── main.tf                # Main configuration
│   ├── variables.tf           # Variable definitions
│   ├── outputs.tf             # Output definitions
│   ├── providers.tf           # Provider configurations
│   ├── terraform.tfvars       # Variable values
│   └── README.md
└── README.md                  # This file
```

## Prerequisites

1. **Local Development Tools**
   - Git
   - Node.js v22.x
   - Docker
   - Terraform v1.7.x
   - Ansible v2.15.x
   - AWS CLI
   - IBM Cloud CLI

2. **Cloud Provider Accounts**
   - AWS Account
   - IBM Cloud Account

## Getting Started

1. **Clone the Repository**
   ```bash
   git clone <repository-url>
   cd devops-engineer-assessment-task
   ```

2. **Set up Infrastructure**
   - Follow instructions in [terraform/README.md](./terraform/README.md)
   - This will create necessary cloud resources

3. **Configure Monitoring**
   - Follow instructions in [ansible/README.md](./ansible/README.md)
   - This will set up Grafana, Prometheus, and Loki

4. **Deploy Application**
   - Follow instructions in [node-app/README.md](./node-app/README.md)
   - Application will be deployed via GitHub Actions

## Architecture

```
                                   ┌─────────────┐
                                   │  GitHub     │
                                   │  Actions    │
                                   └─────┬───────┘
                                         │
                         ┌───────────────┴──────────────┐
                         │                              │
                   ┌─────┴────┐                   ┌─────┴────┐
                   │   AWS    │                   │   IBM    │
                   │   EC2    │                   │  Cloud   │
                   └─────┬────┘                   └─────┬────┘
                         │                              │
                   ┌─────┴────┐                   ┌─────┴────┐
                   │ Node.js  │                   │ Node.js  │
                   │   App    │                   │   App    │
                   └──────────┘                   └──────────┘
                         │                              │
                         └──────────────┬──────────────┘
                                       │
                               ┌───────┴───────┐
                               │  Monitoring   │
                               │   Server     │
                               └─────────────┘
```

## Workflow

1. Push code to GitHub repository
2. GitHub Actions workflow triggers
3. Application is built and pushed to container registries
4. Application is deployed to both AWS and IBM Cloud
5. Monitoring and logging are configured via Ansible

## Support

For any issues or questions, please open an issue in the repository. 