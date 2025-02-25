# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

# Create an S3 bucket for your application assets
resource "aws_s3_bucket" "app_bucket" {
  bucket = "${var.app_name}-${var.environment}"
  
  tags = {
    Name        = "${var.app_name}-${var.environment}"
    Environment = var.environment
  }
}

# Enable versioning for the bucket
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.app_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Create an ECR repository for Docker images
resource "aws_ecr_repository" "app_repository" {
  name = "${var.app_name}-${var.environment}"
  
  image_scanning_configuration {
    scan_on_push = true
  }
  
  tags = {
    Name        = "${var.app_name}-${var.environment}"
    Environment = var.environment
  }
}
