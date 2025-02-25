# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

# Create an S3 bucket for your application assets
resource "aws_s3_bucket" "app_bucket" {
  bucket = "${var.app_name}-${var.environment}-sksri"
  
  tags = {
    Name        = "${var.app_name}-${var.environment}-sksri"
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

# Configure website hosting
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.app_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# Make bucket content publicly accessible
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.app_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.app_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.app_bucket.arn}/*"
      },
    ]
  })
  depends_on = [aws_s3_bucket_public_access_block.public_access]
}
