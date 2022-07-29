# Display Public IP
output "ip_addresses" {
  value = ["${aws_instance.skofy23_webserver.*.public_ip}"]
}