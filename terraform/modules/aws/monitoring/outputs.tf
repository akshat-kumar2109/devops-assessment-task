# output "cloudwatch_agent_role_arn" {
#   description = "ARN of the CloudWatch agent IAM role"
#   value       = aws_iam_role.cloudwatch_agent.arn
# }

# output "cloudwatch_agent_profile_name" {
#   description = "Name of the CloudWatch agent instance profile"
#   value       = aws_iam_instance_profile.cloudwatch_agent.name
# }

# output "ec2_log_group_name" {
#   description = "Name of the CloudWatch log group for EC2 logs"
#   value       = aws_cloudwatch_log_group.ec2_logs.name
# }

# output "node_app_log_group_name" {
#   description = "Name of the CloudWatch log group for Node.js application logs"
#   value       = aws_cloudwatch_log_group.node_app_logs.name
# }

# output "cloudwatch_config_parameter_name" {
#   description = "Name of the SSM parameter storing CloudWatch agent configuration"
#   value       = aws_ssm_parameter.cloudwatch_config.name
# } 