# aws instance public IP
output "IP" {
  value = "${aws_instance.ubuntu.public_ip}"
}