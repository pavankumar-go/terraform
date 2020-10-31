output "Instance_IP" {
    value = aws_instance.ubuntu_vpn_server.public_ip
}