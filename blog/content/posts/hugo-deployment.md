+++
title = 'Site deployment with hugo'
date = 2024-08-09T20:09:12+04:00
draft = false
+++

In this lesson you will learn the easiest way to deploy static websites with [Hugo](https://gohugo.io)

Before we used `terraform` for deployment. But hugo has a built-in solution. For that you need to update your `hugo.toml` file. In section `deployment` you need to add a target.

For example:

```
[deployment]

[[deployment.targets]]

name = "aws"
URL = "s3://my-blog-on-aws-s3-12321213123"
```

Then to deploy files to S3 bucket you need to run:

```
hugo deploy --aws
```

*Note*: before run it you need to create S3 bucket with specific settings. For more details read this [article](https://docs.aws.amazon.com/AmazonS3/latest/userguide/HostingWebsiteOnS3Setup.html).

