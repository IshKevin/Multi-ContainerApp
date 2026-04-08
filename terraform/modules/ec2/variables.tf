variable "project_name" {
  description = "Passed from root to name resources"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance size"
  type        = string
  default     = "t3.micro"
}