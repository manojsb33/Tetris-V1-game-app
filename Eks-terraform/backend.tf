terraform {
  backend "s3" {
    bucket = "123456789123" 
    key    = "EKS/app/terraform.tfstate"
    region = "ap-southeast-2"
  }
}
