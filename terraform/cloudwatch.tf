# IAM role for CloudWatch Agent
resource "aws_iam_role" "cloudwatch_agent" {
  name = "CloudWatchAgentRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "CloudWatch Agent Role"
  }
}

# IAM instance profile
resource "aws_iam_instance_profile" "cloudwatch_agent" {
  name = "CloudWatchAgentProfile"
  role = aws_iam_role.cloudwatch_agent.name
}

# CloudWatch Agent policy
resource "aws_iam_role_policy_attachment" "cloudwatch_agent" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  role       = aws_iam_role.cloudwatch_agent.name
}

# Create CloudWatch Log Groups
resource "aws_cloudwatch_log_group" "system_syslog" {
  name              = "/prod/system/syslog"
  retention_in_days = 30

  tags = {
    Environment = "prod"
    Type        = "system"
  }
}

resource "aws_cloudwatch_log_group" "system_auth" {
  name              = "/prod/system/auth"
  retention_in_days = 30

  tags = {
    Environment = "prod"
    Type        = "system"
  }
}

resource "aws_cloudwatch_log_group" "application_nodejs" {
  name              = "/prod/application/nodejs"
  retention_in_days = 30

  tags = {
    Environment = "prod"
    Type        = "application"
  }
}

# CloudWatch Dashboard
resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "SystemMetrics"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["System/Linux", "cpu_usage_system", { "stat": "Average" }],
            [".", "cpu_usage_user", { "stat": "Average" }],
            [".", "cpu_usage_idle", { "stat": "Average" }]
          ]
          period = 300
          region = data.aws_region.current.name
          title  = "CPU Usage"
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["System/Linux", "mem_used_percent", { "stat": "Average" }]
          ]
          period = 300
          region = data.aws_region.current.name
          title  = "Memory Usage"
        }
      },
      {
        type   = "log"
        x      = 0
        y      = 6
        width  = 24
        height = 6

        properties = {
          query = "SOURCE '/prod/application/nodejs' | fields @timestamp, @message | sort @timestamp desc | limit 100"
          region = data.aws_region.current.name
          title  = "Application Logs"
        }
      }
    ]
  })
}

# Get current region
data "aws_region" "current" {} 