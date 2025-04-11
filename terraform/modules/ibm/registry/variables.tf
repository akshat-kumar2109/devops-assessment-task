variable "namespace_name" {
  description = "Name of the container registry namespace"
  type        = string
}

variable "resource_group_id" {
  description = "ID of the resource group"
  type        = string
}

variable "region" {
  description = "Region where the container registry will be created"
  type        = string
  default     = "global"
}

variable "create_iam_policy" {
  description = "Whether to create IAM policy for the registry"
  type        = bool
  default     = false
}

variable "user_email" {
  description = "Email of the user to grant registry access"
  type        = string
  default     = ""
}

variable "registry_access_roles" {
  description = "List of roles to assign to the user for registry access"
  type        = list(string)
  default     = ["Manager", "Reader"]
}

variable "enable_retention_policy" {
  description = "Whether to enable retention policy for the registry"
  type        = bool
  default     = false
}

variable "retention_images_per_repo" {
  description = "Number of images to retain per repository when retention policy is enabled"
  type        = number
  default     = 10
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = list(string)
  default     = []
} 