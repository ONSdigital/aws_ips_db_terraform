terraform {
  backend "s3" {
    bucket         = "socsur-ips-terraform-state"
    key            = "ips/testdb/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "socsur-ips-terraform-locks"
    encrypt        = true
  }
}