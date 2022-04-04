resource "aws_route53_zone" "near_prime" {
  name = "nearprime.io"
}

resource "aws_route53_record" "node_route53_records" {
  for_each = var.primelab_nodes
  zone_id  = aws_route53_zone.near_prime.zone_id
  name     = "${each.key}.nearprime.io"
  type     = "CNAME"
  ttl      = "300"
  records  = [aws_lb.primelab_nlb[each.key].dns_name]
}


resource "aws_route53_record" "near_prime_acm_validation" {
  for_each = {
    for dvo in aws_acm_certificate.near_prime.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.near_prime.zone_id
}

resource "aws_acm_certificate" "near_prime" {
  domain_name       = "*.${aws_route53_zone.near_prime.name}"
  validation_method = "DNS"
}