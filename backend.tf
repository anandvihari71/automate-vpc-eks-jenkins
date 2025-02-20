terraform {
  backend "s3" {
    bucket         = "automate-terraformbackup"
    key            = "jenkins/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "enable-state-locking-table"
  }
}