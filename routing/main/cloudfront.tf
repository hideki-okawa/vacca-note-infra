resource "aws_cloudfront_distribution" "this" {
  origin {
    domain_name = data.terraform_remote_state.view_main.outputs.aws_s3_bucket_this.bucket_regional_domain_name
    origin_id   = data.terraform_remote_state.view_main.outputs.aws_s3_bucket_this.id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.static-www.cloudfront_access_identity_path
    }
  }

  enabled             = true
  default_root_object = "index.html"

  aliases = ["www.vacca-note.com"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = data.terraform_remote_state.view_main.outputs.aws_s3_bucket_this.id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["JP"]
    }
  }

  tags = {
    Name = local.system_name
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn = aws_acm_certificate.www.arn
    minimum_protocol_version       = "TLSv1"
    ssl_support_method             = "sni-only"
  }
}

resource "aws_cloudfront_origin_access_identity" "static-www" {}