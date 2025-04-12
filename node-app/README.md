# Node.js Application

This directory contains the Node.js application code and Dockerfile for deployment.

## GitHub Actions Secrets

The following secrets need to be configured in your GitHub repository:

### Deploy Key
- `DEPLOY_KEY`: The private SSH key content used for deployment
  - Add the private key content as the secret value `SSH_PRIVATE_KEY`

### AWS Configuration
- `AWS_ACCESS_KEY_ID`: Your AWS access key
- `AWS_SECRET_ACCESS_KEY`: Your AWS secret key
- `AWS_REGION`: Your AWS region (e.g., us-east-1)
- `AWS_ECR_REPOSITORY`: Your ECR repository name
- `EC2_HOST`: EC2 Instance IP 

### IBM Cloud Configuration
- `IBM_API_KEY`: Your IBM Cloud API key
- `IBM_INSTANCE_HOST`: Your IBM Instance Floating IP
- `IBM_REGION`: Your IBM Cloud region
- `ICR_NAMESPACE`: Your IBM Cloud ICR Namespace
- `ICR_REPOSITORY_NAME`: Define Repository Name

## Local Development

1. **Install Dependencies**
   ```bash
   npm install
   ```

2. **Run Application Locally**
   ```bash
   npm start
   ```

3. **Build Docker Image Locally**
   ```bash
   docker build -t node-app .
   ```

4. **Run Docker Container Locally**
   ```bash
   docker run -p 5000:5000 node-app
   ```

## Application Structure

```
node-app/
├── index.js               # Main application file
├── Dockerfile            # Container configuration
├── .dockerignore        # Docker build exclusions
├── package.json         # Dependencies and scripts
├── package-lock.json    # Locked dependencies
├── node_modules/        # Installed dependencies
└── README.md           # This file
```

## Environment Variables

The application uses the following environment variables:
- `PORT`: Application port (default: 5000)
