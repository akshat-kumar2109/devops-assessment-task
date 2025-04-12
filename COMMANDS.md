# Step-by-Step Setup Guide

This guide provides the complete sequence of commands and steps needed to set up the entire infrastructure and deploy the application.

## Prerequisites

Ensure you have the following tools installed:
- [Terraform](./terraform/README.md#prerequisites)
- [Ansible](./ansible/README.md#prerequisites)
- [AWS CLI](https://aws.amazon.com/cli/)
- [IBM Cloud CLI](https://cloud.ibm.com/docs/cli)
- [Docker](https://docs.docker.com/get-docker/)
- [Node.js](https://nodejs.org/) (for local development)

## 1. Generate Deploy Key

1. Create an SSH key pair for deployment:
   ```bash
   ssh-keygen -t rsa -b 4096 -f terraform/deployer-key deployer-key -N ""
   ```

2. This will create two files:
   - `terraform/deployer-key` (private key)
   - `terraform/deployer-key.pub` (public key)

3. The private key (`deployer-key`) content will be used in GitHub Actions secrets

## 2. Configure GitHub Actions Secrets

Configure all required secrets in your GitHub repository:

1. Go to your repository settings
2. Navigate to "Secrets and variables" → "Actions"
3. Add the following secrets:
   - `SSH_PRIVATE_KEY`: Content of `terraform/deployer-key` (private key)
   - Other secrets as specified in the [Node.js application README](./node-app/README.md#github-actions-secrets)

## 3. Set Up Cloud Infrastructure with Terraform

1. Navigate to the Terraform directory:
   ```bash
   cd terraform
   ```

2. Create a `terraform.tfvars` file with your variables as specified in the [Terraform README](./terraform/README.md#required-variables).

3. Initialize and apply Terraform:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

4. Note down the outputs, especially the monitoring server IP and application instance IPs.

## 4. Configure and Run Ansible Playbook

1. Navigate to the Ansible directory:
   ```bash
   cd ../ansible
   ```

2. Update the monitoring server IP in `group_vars/all.yml`:
   ```yaml
   monitor_host: "YOUR_MONITORING_SERVER_IP"
   ```

3. Update ansible/roles/grafana/files/ec2-instance-metrics-dashboard.json with EC2 instance IP

4. Update ansible/roles/grafana/files/ibm-instance-metrics-dashboard.json with IBM instance IP

5. Use inventory.ini.template to create inventory.ini file and update it with Monitoring server, EC2 Instance and IBM Instance IPs.

3. Run the Ansible playbook:
   ```bash
   ansible-playbook -i inventory.ini site.yml install-tools.yml
   ```

## 5. Deploy Application

1. Push your changes to the main branch:
   ```bash
   git add .
   git commit -m "Initial setup"
   git push origin main
   ```

2. The GitHub Actions workflow will automatically:
   - Build the Node.js application
   - Create Docker images
   - Push to AWS ECR and IBM Container Registry
   - Deploy to both cloud instances

## 6. Verify Setup

1. Check Grafana Dashboard:
   - Access Grafana at `http://MONITORING_SERVER_IP:3000`
   - Default credentials in [Ansible README](./ansible/README.md#default-credentials)

2. Verify Application:
   - AWS Instance: `http://AWS_INSTANCE_IP`
   - IBM Instance: `http://IBM_INSTANCE_IP`
   - Health Check: `/health`
   - Metrics: `/metrics`

## Component-Specific Documentation

- [Node.js Application Documentation](./node-app/README.md)
- [Terraform Infrastructure Documentation](./terraform/README.md)
- [Ansible Configuration Documentation](./ansible/README.md)

## Cleanup

To tear down the infrastructure:

1. Remove application instances:
   ```bash
   cd terraform
   terraform destroy
   ```

2. Clean up container registries:
   ```bash
   # AWS ECR
   aws ecr batch-delete-image --repository-name YOUR_REPO_NAME --image-ids imageTag=latest

   # IBM Container Registry
   ibmcloud cr image-rm YOUR_REGISTRY_URL/YOUR_NAMESPACE/YOUR_REPO_NAME:latest
   ``` 