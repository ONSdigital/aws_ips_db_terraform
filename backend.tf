terraform {
  backend "s3" {
    bucket = "socsur-ips-aws-b-terraform-state"
    key            = "ips/testdb/terraform.tfstate"
    region = "eu-west-2"
    dynamodb_table = "socsur-ips-aws-b-terraform-locks"
    encrypt = true
  }
}