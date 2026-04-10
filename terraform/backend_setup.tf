resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "state_bucket" {
  bucket        = "multicontainerlab-state-${random_id.bucket_suffix.hex}"
  force_destroy = true
}

resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraform-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}