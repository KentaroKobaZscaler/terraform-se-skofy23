# Output Public and DNS IP
output "ip_addresses" {
   value = formatlist("http://%s", aws_instance.skofy23_webserver.*.public_ip)
}

output "public_dns" {
    value = formatlist("http://%s", aws_instance.skofy23_webserver.*.public_dns)
}