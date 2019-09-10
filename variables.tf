variable "main_address_space" {
  default = "10.1.0.0/16"
}

variable "public_subnet_count" {
  default = 1
}

variable "private_subnet_count" {
  default = 2
}

variable "cidr_block_all" {
  default = "0.0.0.0/0"
}

# Mandataory inputs
variable "bastion_ingress_ip" {
}

variable "deploy_key_name" {
}

variable "aws_access_key" {
}

variable "aws_secret_key" {
}

variable "common_name" {
}

variable "arn_certificate" {
}