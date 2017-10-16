variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "bucket" {}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "eu-west-1"
}

resource "aws_s3_bucket" "b" {
  bucket = "${var.bucket}"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

output "artifacts-website" {
  value = "${aws_s3_bucket.b.website_endpoint}"
}

output "artifact-bucket" {
  value = "${aws_s3_bucket.b.bucket}"
}
