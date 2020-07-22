provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "static_site" {
  bucket = var.bucket_name
  acl    = "public-read"
  #policy = "${file("policy.json")}"
    website {
    index_document = "index.html"
    error_document = "error.html"
  }
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowPublicReadAccess",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "s3:GetObject"
      ],
      "Resource": [
        "arn:aws:s3:::${var.bucket_name}/*"
      ]
    }
  ]
}
POLICY
}

resource "aws_s3_bucket_object" "index" {
  #bucket = "aws_s3_bucket.static_site.bucket"
  bucket       = "${aws_s3_bucket.static_site.bucket}"
  key          = "index.html"
  source       = "html/index.html"
  content_type = "text/html"
  etag         = "${md5(file("html/index.html"))}"
  #acl          = "public-read"
}

resource "aws_s3_bucket_object" "error" {
  bucket       = "${aws_s3_bucket.static_site.bucket}"
  key          = "error.html"
  source       = "html/error.html"
  content_type = "text/html"
  etag         = "${md5(file("html/error.html"))}"
  #acl          = "public-read"
}