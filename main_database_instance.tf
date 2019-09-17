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
      "Name"      = "${local.common_name_prefix}-db-sg"
      "FilterKey" = "${local.common_name_prefix}-DB-Security-Group"
    },
  )
}


resource "aws_security_group_rule" "db_sg_self" {
  from_port = 0
  protocol  = -1
  to_port   = 0
  type      = "ingress"
  self      = true

  // rules associated with security group:
  security_group_id = aws_security_group.db-sg.id
}

resource "aws_security_group_rule" "db_sg_from_nat" {
  from_port = 0
  protocol  = -1
  to_port   = 0
  type      = "ingress"
  // traffic from:
  source_security_group_id = aws_security_group.natsg.id

  // rules associated with security group:
  security_group_id = aws_security_group.db-sg.id
}

resource "aws_db_instance" "default" {
  allocated_storage = 20
  storage_type      = "gp2"
  engine            = "mysql"
  engine_version    = "5.7"
  instance_class    = var.instance_class

  name       = local.common_name_prefix
  identifier = local.common_name_prefix

  username = var.db_user_name
  password = var.db_password

  parameter_group_name = var.parameter_group_name

  vpc_security_group_ids = [aws_security_group.db-sg.id]
  db_subnet_group_name   = aws_db_subnet_group.db-subnet.name

  tags = merge(
    local.module_common_tags,
    {
      "Name" = local.common_name_prefix
    },
  )
}