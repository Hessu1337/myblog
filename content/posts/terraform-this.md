---
title: "Terraform this"
date: 2020-02-05T07:54:40+01:00
draft: false

---


For now this blog is hosted with AWS on different services like S3 or Cloudfront (CDN) but these were made manually on the AWS console, It's easy but not repeatable automatically. The other bad side with this "test" infrastructure is the state, you cannot know if it has been modified and who did it making the reproducibility even harder.

Terraform joined the game, the best feature of this tool is the idempotency, if you apply twice the same infrastructure description, the first time it will create it and the next apply will do nothing, whenever you plan or apply, Terraform compare the local .tfstate and the provider state. You can retrieve outputs, like endpoints that you didn't know before applying.

Here a good introduction to Terraform by Mathieu Herbert : https://www.youtube.com/watch?v=KCgkFpt9dfk

I made the first part of my blog with terraform, the S3 bucket and the Cloudfront distribution, the actual infrastructure is a bit different from my Terraform, manually I put the bucket private and Cloudfront had the right to retrieve objects based on OAI (Origin access identity), I don't really need it, usefull if you want nobody else than Cloudfront hit the bucket.

Codebuild is far more difficult to integrate in a terraform, even more if you used things like external webhook. On the webconsole, it's pretty easy by checking some boxes, Oauth to your github account and tada it works. But in terraform it is a different kettle of fish because you have to notice Github for the Codebuild webhook, give it a provider, with a token, it's easier with Codecommit I admit. Actually, webhook still the only step I should do manually.

Right now, everything should be managed by Terraform :

https://github.com/Hessu1337/myblog/tree/master/terraform