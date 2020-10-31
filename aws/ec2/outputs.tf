# aws instance public IP
output "IP" {
  value = "${aws_instance.ubuntu.public_ip}"
}

# nameservers of route53
output "nameservers" {
  value = "${aws_route53_zone.mydomain.name_servers}"
}