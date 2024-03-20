terraform {
  backend "s3" {
    bucket = "123456789123" 
    key    = "Jenkins/terraform.tfstate"
    region = "ap-southeast-2"
  }
}
