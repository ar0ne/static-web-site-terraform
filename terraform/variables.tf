variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}


variable "bucket_prefix" {
  type        = string
  description = "Prefix for s3 bucket name"
  default     = "blog"
}


variable "environment" {
  type        = string
  description = "Environment (dev/qa/production)"
  default     = "dev"
}

variable "cors_rules" {
  description = "List of CORS rules."
  type = list(object({
    allowed_headers = optional(set(string)),
    allowed_methods = set(string),
    allowed_origins = set(string),
    expose_headers  = optional(set(string)),
    max_age_seconds = optional(number)
  }))
  default = []
}


locals {
  bucket_name = "${var.bucket_prefix}-bucket-${var.environment}-${random_string.name.result}"
}


