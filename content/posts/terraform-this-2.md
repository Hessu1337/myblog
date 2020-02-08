---
title: "Terraform This 2"
date: 2020-02-08T09:58:39+01:00
draft: true

---

## The domain

Ok, today we welcome the gonzague.dev domain! Another opportunity to use Terraform 👍

First of all I revised my way to organize terraform folder, passing variables between modules became painful. Now every service I want to leverage is in a specific file with explicit name like this : 

````
terraform
├── certificate.tf
├── cloudfront.tf
├── codebuild.tf
├── main.tf
├── output.tf
├── route53.tf
├── s3.tf
└── variables.tf
````

I don't know if it's the best practice, it's easier but it can't build a single module with -target parameter

## Regions ...

.dev domains implies HTTPS and it implies certificates ! You must know that Cloudfront supports only certificates issued by Certificate Manager in **us-east-1** ! (hello terraform provider)

Another good thing to know, S3 cannot serve ssl certs, I had to create two distributions, one for www.gonzague.dev and the other one for apex domain gonzague.dev (redirect to an empty S3 bucket with website redirect to www. domain, tricky 🤔) because only cloudfront can expose certificate for HTTPS.

Codebuild "runners" will target his region when aws cli commands are invoked, I'm kinda locked with this region ...

## External configuration

Two things made some problems

1. Domain provider : I purchased the domain to OVH and everytime I will create my infrastructure with terraform the hosted zone will be generated and dns given by AWS will change, How can I apply these changes to OVH too?
2. GitHub authentification : In order to integrate webhooks, terraform had to provide the Codebuild endpoint