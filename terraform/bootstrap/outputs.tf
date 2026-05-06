output "s3_bucket_name" {
  value       = aws_s3_bucket.terraform_state.bucket
  description = "The name of the S3 bucket to store Terraform state"
}

output "aws_region" {
  value       = "us-east-1"
  description = "The AWS region"
}
