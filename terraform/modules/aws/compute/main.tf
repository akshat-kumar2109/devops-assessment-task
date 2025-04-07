data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = aws_key_pair.deployer.key_name
  subnet_id = var.subnet_id
  vpc_security_group_ids = [ var.security_group_id ]
  availability_zone = var.availability_zone
  iam_instance_profile = var.cloudwatch_agent_profile_name

  user_data = <<-EOF
              #!/bin/bash
              # Install CloudWatch agent
              wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
              dpkg -i amazon-cloudwatch-agent.deb
              
              # Start CloudWatch agent with SSM parameter configuration
              /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c ssm:${var.cloudwatch_config}
              
              # Create directory for Node.js application logs
              mkdir -p /var/log/node-app
              chown -R ubuntu:ubuntu /var/log/node-app
              EOF

  tags = merge(var.tags, {
    Name = var.instance_name
  })
}

resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = var.public_key
}

data "aws_region" "current" {}