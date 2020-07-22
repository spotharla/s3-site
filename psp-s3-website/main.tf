provider "aws" {
  region = "eu-west-2"
}

terraform {
  backend "s3" {
    bucket = "s3-backend2020"
    key    = "terraform/dev/terraform.tfstate"
    region = "eu-west-2"
  }
}

module "s3-website" {
  source = "../modules/s3-website"
}

output "website_endpoint" {
  value = module.s3-website.website_endpoint
}