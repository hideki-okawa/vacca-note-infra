resource "aws_route53_zone" "this" {
  name = local.domain_name
}

resource "aws_route53_record" "root_certificate_validation" {
  for_each = {
    for dvo in aws_acm_certificate.root.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  name    = each.value.name
  records = [each.value.record]
  ttl     = 60
  type    = each.value.type
  zone_id = aws_route53_zone.this.id
}

resource "aws_route53_record" "www_certificate_validation" {
  for_each = {
    for dvo in aws_acm_certificate.www.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  name    = each.value.name
  records = [each.value.record]
  ttl     = 60
  type    = each.value.type
  zone_id = aws_route53_zone.this.id
}

resource "aws_route53_record" "root_a" {
  count = 1

  name    = "api.${aws_route53_zone.this.name}"
  type    = "A"
  zone_id = aws_route53_zone.this.zone_id

  alias {
    evaluate_target_health = true
    name                   = aws_lb.this[0].dns_name
    zone_id                = aws_lb.this[0].zone_id
  }
}

resource "aws_route53_record" "wwww_a" {
  count = 1

  name    = "www.${aws_route53_zone.this.name}"
  type    = "A"
  zone_id = aws_route53_zone.this.zone_id

  alias {
    evaluate_target_health = true
    name                   = aws_cloudfront_distribution.this.domain_name
    zone_id                = aws_cloudfront_distribution.this.hosted_zone_id
  }
}