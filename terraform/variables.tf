variable "aws_region" {
  description = "Target AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "project_name" {
  description = "Project name used for tagging and naming"
  type        = string
  default     = "MultiContainerLab"
}

variable "instance_type" {
  description = "EC2 instance size"
  type        = string
  default     = "t3.micro"
}