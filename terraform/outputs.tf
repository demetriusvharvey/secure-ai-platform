output "rke2_public_ip" {
  value = aws_eip.rke2_eip.public_ip
}
output "ssh_command" {
  value = "ssh -i rke2-key.pem ubuntu@${aws_instance.rke2_server.public_ip}"
}
