+++
title = 'How to deploy static website to AWS S3 with terraform'
date = 2024-08-09T19:34:29+04:00
draft = false 
+++

To make your static website public available you could choose from many options on the market, e.g. *github-pages*, *aws s3-websites*, *gc storage*, *netlify* or any other services you prefer.

In this short tutorial, we take a look at deployment with [`terraform`](https://terraform.io).

First of all, you need to install `terraform`. Check documentation for your system:

```
sudo pacman -S terraform
```

Terraform works with many different providers and allows to setup infrastructure by writing declarative tempaltes.

Clone repository and open folder with templates.

```
git clone git@github.com:ar0ne/static-web-site-terraform.git
cd static-web-site-terraform/terraform
```

Now you need to download required providers (e.g. `aws`).

```
terraform init
```

Now you could upload this blog to S3 website hosting. When terraform asks to confirm, just type 'yes'. Open url from outputs in your browser.

```
terraform apply
```

Under the hood, terraform will create s3 bucket and setup required ACL and policy. And sync `blog/` folder with the bucket. You could add a new page or update existing, after that if you run `terraform apply` button again, it will upload changes to s3.


## Clean up

To remove uploaded files, just run 

```
terraform destroy
```

and confirm operation.
