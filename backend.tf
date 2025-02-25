terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket-sksri"
    key            = "app-repo/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}
