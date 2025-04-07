output "repository_url" {
  description = "The URL of the repository"
  value       = aws_ecr_repository.node_app.repository_url
}

output "repository_name" {
  description = "The name of the repository"
  value       = aws_ecr_repository.node_app.name
}

output "repository_arn" {
  description = "The ARN of the repository"
  value       = aws_ecr_repository.node_app.arn
} 