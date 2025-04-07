# CI/CD Setup for Node.js Application

This repository contains the CI/CD configuration for deploying a Node.js application to AWS EC2 using GitHub Actions.

## Prerequisites

1. AWS Account with:
   - EC2 instance running
   - ECR repository created
   - IAM user with appropriate permissions

2. GitHub repository secrets:
   - `AWS_ACCESS_KEY_ID`: AWS IAM user access key
   - `AWS_SECRET_ACCESS_KEY`: AWS IAM user secret key
   - `AWS_REGION`: AWS region (e.g., us-east-1)
   - `EC2_HOST`: Public IP or DNS of your EC2 instance
   - `SSH_PRIVATE_KEY`: SSH private key for EC2 instance access

## Setup Instructions

1. Set up the server environment:
   ```bash
   cd ansible
   ansible-playbook -i inventory.ini server-setup.yml
   ```

2. Configure GitHub repository:
   - Go to Settings > Secrets and Variables > Actions
   - Add all required secrets listed above

3. Push code to main branch:
   - The GitHub Actions workflow will automatically:
     - Build the Node.js application
     - Create a Docker image
     - Push to ECR
     - Deploy to EC2

## Workflow Steps

1. **Build**:
   - Checks out code
   - Sets up Node.js
   - Installs dependencies
   - Builds Docker image

2. **Deploy**:
   - Pushes image to ECR
   - Connects to EC2
   - Pulls new image
   - Updates running container

## Monitoring

- Application runs on port 3000
- Check container logs: `docker logs node-app`
- Check container status: `docker ps` 