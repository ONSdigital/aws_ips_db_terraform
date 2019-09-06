data "aws_ami" "nat_instance_ami" {
  most_recent = true
  owners      = ["137112412989"]
  name_regex  = ".*amzn-ami-vpc-nat-2018.*"

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_availability_zones" "available" {
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "ips-vpc-s3"
    key    = "global/s3/terraform.tfstate"
    region = "eu-west-2"
  }
}

