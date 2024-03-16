terraform {
  backend "s3" {
    bucket = "my-first-achivement-in" # Replace with your actual S3 bucket name
    key    = "EKS/app/terraform.tfstate"
    region = "ap-southeast-2"
  }
}
