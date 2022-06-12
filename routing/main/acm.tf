resource "aws_acm_certificate" "root" {
  domain_name = "api.${aws_route53_zone.this.name}"

  validation_method = "DNS"

  tags = {
    Name = "${local.system_name}-link"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "root" {
  certificate_arn = aws_acm_certificate.root.arn
}

resource "aws_acm_certificate" "www" {
  domain_name = "www.${aws_route53_zone.this.name}"

  validation_method = "DNS"

  provider          = aws.virginia
  
  tags = {
    Name = "${local.system_name}-www-link"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "www" {
  provider          = aws.virginia
  certificate_arn = aws_acm_certificate.www.arn
}