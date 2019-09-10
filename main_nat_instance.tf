resource "aws_security_group" "natsg" {
  vpc_id      = aws_vpc.main_vpc.id
  name        = "${local.common_name_prefix}_NAT-security-group"
  description = "Security Group for the NAT Instance for ${local.common_name_prefix}"

//  TODO: I have not replicated ingress and egress for SSH (have not created a bastion) or HTTPS (this will be done last)
  ingress {
    from_port = 80
    protocol  = "tcp"
    to_port   = 80
    cidr_blocks = aws_subnet.private_subnets.*.cidr_block
  }

  ingress {
    from_port = 0
    protocol  = -1
    to_port   = 0
    self      = true
  }

  ingress {
    from_port = 53
    protocol  = "udp"
    to_port   = 53
    cidr_blocks = aws_subnet.private_subnets.*.cidr_block
  }

  ingress {
    from_port = 2222
    protocol  = "tcp"
    to_port   = 2222
    cidr_blocks = aws_subnet.private_subnets.*.cidr_block
  }

  egress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = [var.cidr_block_all]
  }

  egress {
    from_port   = 5432
    protocol    = "tcp"
    to_port     = 5432
    cidr_blocks = concat(
      aws_subnet.private_subnets.*.cidr_block,
      aws_subnet.public_subnets.*.cidr_block,
    )
  }

  egress {
    from_port   = 53
    protocol    = "udp"
    to_port     = 53
    cidr_blocks = [var.cidr_block_all]
  }

  egress {
    from_port   = 2222
    protocol    = "tcp"
    to_port     = 2222
    cidr_blocks = [var.cidr_block_all]
  }

  tags = merge(
    local.module_common_tags,
    {
      "Name" = "${local.common_name_prefix}-nat-instance-sg-db"
    },
  )
}

resource "aws_instance" "nat" {
  ami                         = data.aws_ami.nat_instance_ami.id
  instance_type               = "t2.micro"
  key_name                    = var.deploy_key_name
  associate_public_ip_address = true
  source_dest_check           = false

  subnet_id              = aws_subnet.public_subnets[0].id
  vpc_security_group_ids = [aws_security_group.natsg.id, aws_security_group.public_sg.id]

  tags = merge(
    local.module_common_tags,
    {
      "Name" = "${local.common_name_prefix}-nat-instance-db"
    },
  )
}

