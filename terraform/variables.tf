variable "aws_region" {
  description = "Target AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "project_name" {
  description = "Project name used for tagging and resource naming"
  type        = string
  default     = "MultiContainerLab"
}