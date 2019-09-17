resource "aws_db_subnet_group" "db-subnet" {
  name       = "ips-db-subnet"
  subnet_ids = aws_subnet.private_subnets.*.id

  tags = {
    Name = "ips-db-subnet",
    app  = "ips-db"
  }
}

resource "aws_security_group" "db-sg" {
  vpc_id = aws_vpc.main_vpc.id
  tags = merge(
    local.private_vpc_resource_tags,
    {
      "Name" = "${local.common_name_prefix}-db-sg"
    },
  )
}

  ingress {
    from_port = 5432
    protocol = "tcp"
    to_port = 0
  }

  egress {
    from_port = 0
    protocol = ""
    to_port = 0
  }

}
