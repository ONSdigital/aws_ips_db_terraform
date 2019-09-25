resource "aws_nat_gateway" "this" {
  allocation_id = "${aws_eip.natgw.id}"
  subnet_id = "${aws_subnet.public_subnets[0].id}"

  tags = merge(
  local.module_common_tags,
    {
      "Name" = "${local.common_name_prefix}-nat-gateway-db"
    },
  )

  depends_on = ["aws_internet_gateway.igw"]
}

resource "aws_eip" "natgw" {}
