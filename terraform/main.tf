resource "aws_s3_bucket" "blog" {
  bucket = local.bucket_name
}

resource "aws_s3_bucket_ownership_controls" "blog" {
  bucket = aws_s3_bucket.blog.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "blog" {
  bucket = aws_s3_bucket.blog.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "blog" {
  depends_on = [
    aws_s3_bucket_ownership_controls.blog,
    aws_s3_bucket_public_access_block.blog,
  ]

  bucket = aws_s3_bucket.blog.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "public_available" {
    bucket = aws_s3_bucket.blog.id
    policy = data.aws_iam_policy_document.public_available.json
}


data "aws_iam_policy_document" "public_available" {
    statement {
        actions = [
            "s3:GetObject"
        ]

        principals {
            type = "*"
            identifiers = ["*"]
        }

        resources = [
            "${aws_s3_bucket.blog.arn}/*"
        ]

    }
}


resource "random_string" "name" {
  length  = 16
  special = false
  lower   = true
  upper   = false
}


resource "aws_s3_bucket_website_configuration" "blog_configuration" {
  bucket = aws_s3_bucket.blog.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }
}

resource "aws_s3_object" "static_files" {
  for_each = module.template_files.files

  bucket       = aws_s3_bucket.blog.bucket
  key          = each.key
  content_type = each.value.content_type

  source  = each.value.source_path
  source_hash  = filemd5(each.value.source_path)
}


module "template_files" {
  source = "hashicorp/dir/template"

  base_dir = "../blog/public"
}


resource "aws_s3_bucket_cors_configuration" "web" {
  count = length(var.cors_rules) > 0 ? 1 : 0

  bucket = aws_s3_bucket.blog.id

  dynamic "cors_rule" {
    for_each = var.cors_rules

    content {
      allowed_headers = cors_rule.value["allowed_headers"]
      allowed_methods = cors_rule.value["allowed_methods"]
      allowed_origins = cors_rule.value["allowed_origins"]
      expose_headers  = cors_rule.value["expose_headers"]
      max_age_seconds = cors_rule.value["max_age_seconds"]
    }
  }
}
