provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = "eu-west-2"
  version    = "~> 2.23.0"
}

resource "aws_vpc" "main_vpc" {
  cidr_block           = var.main_address_space
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = local.module_common_tags
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = merge(
    local.public_vpc_resource_tags,
    {
      "Name" = "${local.common_name_prefix}-internet-gateway"
    },
  )
}
