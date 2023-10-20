
resource "aws_dynamodb_table" "meethare_dynamodbtable" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST" 
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.meethare_dynamodbtable.name
  description = "The name of the DynamoDB table"
}