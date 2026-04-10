output "instance_public_ip" {
  description = "Public IP of the EC2 instance for Ansible"
  value       = module.compute.public_ip
}

output "ssh_key_name" {
  description = "Name of the generated key pair"
  value       = module.compute.key_name
}

output "backend_s3_bucket" {
  description = "S3 bucket for Terraform state"
  value       = aws_s3_bucket.state_bucket.bucket
}

output "backend_dynamodb_table" {
  description = "DynamoDB table for state locking"
  value       = aws_dynamodb_table.terraform_lock.name
}