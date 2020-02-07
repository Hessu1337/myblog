provider "aws" {
  region = "eu-west-3"
}

module "s3" {
  source = "./s3"

  s3bucket = var.s3bucket
}

module "codebuild" {
  source = "./codebuild"

  s3bucket   = var.s3bucket
  bucket     = module.s3.bucket
  repository = var.repository
}

module "cloudfront" {
  source = "./cloudfront"

  bucket_domain_name = module.s3.bucket_domain_name
  bucket             = module.s3.bucket
}
