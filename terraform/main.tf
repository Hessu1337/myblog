provider "aws" {
  region = "us-east-1"
}

variable "www_domain_name" {
  default = "www.gonzague.dev"
}

variable "root_domain_name" {
  default = "gonzague.dev"
}

variable repository {
  description = "GitHub repository"
  default     = "https://github.com/Hessu1337/myblog"
}