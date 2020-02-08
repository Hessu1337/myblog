resource "aws_iam_role" "r" {
  name = "myblog-codebuild-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "p" {
  role = aws_iam_role.r.name

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": [
        "*"
      ],
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "arn:aws:s3:::${var.www_domain_name}",
        "arn:aws:s3:::${var.www_domain_name}/*"
      ]
    }
  ]
}
POLICY
}

resource "aws_codebuild_project" "cb" {
  name          = "myblog-cb-project"
  description   = "myblog_codebuild_project"
  build_timeout = "5"
  service_role  = aws_iam_role.r.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type     = "S3"
    location = var.www_domain_name
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:3.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

  }

  logs_config {
    s3_logs {
      status   = "ENABLED"
      location = "${var.www_domain_name}/build-log"
    }
  }

  source {
    type            = "GITHUB"
    location        = "${var.repository}.git"
    git_clone_depth = 0
  }
}

# resource "aws_codebuild_webhook" "w" {
#   project_name = aws_codebuild_project.cb.name
# }

# resource "github_repository_webhook" "ghw" {
#   active     = true
#   events     = ["push"]
#   repository = var.repository

#   configuration {
#     url          = aws_codebuild_webhook.w.payload_url
#     secret       = aws_codebuild_webhook.w.secret
#     content_type = "json"
#     insecure_ssl = false
#   }
# }