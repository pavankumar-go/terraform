resource "aws_route53_zone" "mydomain" {
  name = "arepo.tz"
}

resource "aws_route53_record" "arepo-record" {
  zone_id = aws_route53_zone.mydomain.zone_id
  name = "ubuntu.arepo.tz"
  type = "A"
  ttl = 300
  records = [aws_instance.ubuntu.public_ip]
}