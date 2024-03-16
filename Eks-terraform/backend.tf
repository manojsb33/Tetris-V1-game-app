terraform {
  backend "s3" {
    bucket = "my-first-achivement-in" # Replace with your actual S3 bucket name
    key    = "Eks/app/terraform.tfstate"
    region = "us-east-1"
  }
}
