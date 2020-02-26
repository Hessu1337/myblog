---
title: "How This Blog Is Made"
date: 2020-01-30T17:30:58+01:00
draft: false

---



## Idea behind

I wanted something simple, using github and aws, a simple workflow : write then push and voila.

This exercise was for experience and knowledge, structuring ideas, formatting markdowns and much more

It will help me to share some content and practice my written english too, hope you will like.

## Getting started

The main component is gohugo, a simple framework written in golang, it is easy to use the binary let you 

- Generate a static website with posts generated from markdown (md) files.
- Deploy it to a target, Simple Storage Service (S3) from Amazon Web Services (AWS) in our case

Another thing I wanted is GitHub for version control, I've see some example to deploy with GitHub actions but in the other hand I desired to use AWS as much as possible.

The deployment and hosting is handled by different managed services

- Static website hosting with S3, it can handle HTTP requests and require simple configuration, index and error html files.
- CI/CD Pipeline by CodeBuild and CodePipeline, it gives you an environment for running hugo, generating statics files and deploy them to S3, it is triggered by GitHub webhooks when a post/code is pushed.
- Cloudfront as cache and HTTPS terminaison

## Next Step

This blog is supposed to be populated at first and the infrastructure will evolve too, first thing will be Infrastructure as code (IaC) with terraform, another repository will be created and new stages will be added to the pipeline, the deployment target will be replaced with something more scalable, probably Kubernetes with Fargate. Another good thing will be a domain name managed by route53.
