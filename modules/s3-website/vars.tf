variable "bucket_name" {
  description = "The name of the AWS S3 bucket this website will be published to."
  default     = "psplabs.tk"
}

variable "region" {
  default = "eu-west-2"
}