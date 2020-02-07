output "bucket" {
  value = aws_s3_bucket.b.bucket
}

output "website_endpoint" {
  value = aws_s3_bucket.b.website_endpoint
}

output "bucket_id" {
  value = aws_s3_bucket.b.id
}

output "bucket_domain_name" {
  value = aws_s3_bucket.b.bucket_domain_name
}
