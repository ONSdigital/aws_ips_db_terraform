variable "main_address_space" {
  default = "10.31.0.0/16"
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

variable db_password {
}
variable db_user_name {
}

variable instance_class {
  type    = "string"
  default = "db.t3.meduim"
}

variable parameter_group_name {
  type    = "string"
  default = "ips-mysql"
}