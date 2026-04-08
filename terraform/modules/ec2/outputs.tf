output "public_ip" {
  description = "Public IP of the web server"
  value       = aws_instance.web.public_ip
}

output "key_name" {
  description = "The name of the AWS key pair"
  value       = aws_key_pair.generated.key_name
}

output "instance_id" {
  description = "ID of the created instance"
  value       = aws_instance.web.id
}