provider "aws" {
  region = "eu-west-1"
}
variable s3bucket {
  description = "Blog S3 Bucket"
  default     = "blog.test.gonzague.pagin"
}
module "s3" {
  source   = "./s3"
  s3bucket = var.s3bucket
}
module "cloudfront" {
  source = "./cloudfront"

  website_endpoint = "${module.s3.website_endpoint}"
  bucket           = "${module.s3.bucket}"
}
