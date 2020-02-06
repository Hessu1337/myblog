variable "s3bucket" {
  type = string
}

resource "aws_s3_bucket" "b" {
  bucket = var.s3bucket
  acl    = "public-read"

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }

  website {
    index_document = "index.html"
    error_document = "404.html"
  }

  policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
    {
        "Sid": "PublicReadForGetBucketObjects",
        "Effect": "Allow",
        "Principal": {
            "AWS": "*"
         },
         "Action": "s3:GetObject",
         "Resource": "arn:aws:s3:::${var.s3bucket}/*"
    }]
}
EOF
}

output "bucket" {
  value = aws_s3_bucket.b.bucket
}

output "website_endpoint" {
  value = aws_s3_bucket.b.website_endpoint
}

output "bucket_id" {
    value = aws_s3_bucket.b.id
}