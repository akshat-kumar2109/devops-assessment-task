variable "repository_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "node-app"
}

variable "tags" {
  description = "Tags to be applied to the ECR repository"
  type        = map(string)
  default     = {}
} 