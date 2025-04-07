resource "aws_iam_role" "cloudwatch_agent" {
  name = "${var.project_name}-cloudwatch-agent-role"

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

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "cloudwatch_agent" {
  role       = aws_iam_role.cloudwatch_agent.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_instance_profile" "cloudwatch_agent" {
  name = "${var.project_name}-cloudwatch-agent-profile"
  role = aws_iam_role.cloudwatch_agent.name
}

resource "aws_cloudwatch_log_group" "ec2_logs" {
  name              = "/aws/ec2/${var.project_name}"
  retention_in_days = var.log_retention_days

  tags = var.tags
}

resource "aws_cloudwatch_log_group" "node_app_logs" {
  name              = "/aws/node-app/${var.project_name}"
  retention_in_days = var.log_retention_days

  tags = var.tags
}

locals {
  cloudwatch_config = jsonencode({
    agent = {
      metrics_collection_interval = 60
      run_as_user                = "root"
    }
    metrics = {
      namespace = "${var.project_name}/EC2"
      metrics_collected = {
        cpu = {
          measurement = [
            "cpu_usage_idle",
            "cpu_usage_user",
            "cpu_usage_system"
          ]
          metrics_collection_interval = 60
        }
        mem = {
          measurement = [
            "mem_used_percent",
            "mem_total",
            "mem_used",
            "mem_free"
          ]
          metrics_collection_interval = 60
        }
        disk = {
          measurement = [
            "disk_used_percent",
            "disk_free",
            "disk_total",
            "disk_used"
          ]
          resources = ["/"]
          metrics_collection_interval = 60
        }
      }
    }
    logs = {
      logs_collected = {
        files = {
          collect_list = [
            {
              file_path = "/var/log/syslog"
              log_group_name = aws_cloudwatch_log_group.ec2_logs.name
              log_stream_name = "{instance_id}"
            },
            {
              file_path = "/var/log/node-app/*.log"
              log_group_name = aws_cloudwatch_log_group.node_app_logs.name
              log_stream_name = "{instance_id}-{filename}"
            }
          ]
        }
      }
    }
  })
}

resource "aws_ssm_parameter" "cloudwatch_config" {
  name  = "/${var.project_name}/cloudwatch-agent-config"
  type  = "String"
  value = local.cloudwatch_config

  tags = var.tags
}

resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${var.project_name}-dashboard"

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
            ["${var.project_name}/EC2", "cpu_usage_user", { "stat": "Average" }],
            ["${var.project_name}/EC2", "cpu_usage_system", { "stat": "Average" }],
            ["${var.project_name}/EC2", "cpu_usage_idle", { "stat": "Average" }]
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
            ["${var.project_name}/EC2", "mem_used_percent", { "stat": "Average" }]
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
          query = "SOURCE '${aws_cloudwatch_log_group.ec2_logs.name}' | fields @timestamp, @message\n| sort @timestamp desc\n| limit 100"
          region = data.aws_region.current.name
          title  = "System Logs"
          view   = "table"
        }
      },
      {
        type   = "log"
        x      = 0
        y      = 12
        width  = 24
        height = 6

        properties = {
          query = "SOURCE '${aws_cloudwatch_log_group.node_app_logs.name}' | fields @timestamp, @message\n| sort @timestamp desc\n| limit 100"
          region = data.aws_region.current.name
          title  = "Node.js Application Logs"
          view   = "table"
        }
      }
    ]
  })
}

data "aws_region" "current" {} 