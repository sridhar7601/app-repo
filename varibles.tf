variable "aws_region" {
  description = "AWS region for all resources"
  type        = string
  default     = "ap-south-1"
}

variable "app_name" {
  description = "Name of the application"
  type        = string
  default     = "my-app"
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
}
