output "s3website" {
  value = module.s3.website_endpoint
}

output "cdn_domain_name" {
  value = module.cloudfront.cdn_domain_name
}
