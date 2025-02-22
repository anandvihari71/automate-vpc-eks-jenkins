terraform {
  backend "s3" {
    bucket  = "automate-terraformbackup"
    key     = "eks/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true

  }
}