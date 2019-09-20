output "subnet_ids" {
  value = [
    aws_subnet.public_subnets.*.id,
    aws_subnet.private_subnets.*.id,
  ]
}

output "private_subnet_ids" {
  value = [
    aws_subnet.private_subnets.*.id,
  ]
}

output "public_subnet_ids" {
  value = [
    aws_subnet.public_subnets.*.id,
  ]
}

output "vpc_id" {
  value       = aws_vpc.main_vpc.id
  description = "The VPC id created"
}

output "aws_internet_gateway" {
  value = aws_internet_gateway.igw.id
}

output "aws_route_table_public" {
  value = [
    aws_route_table.route_tbl_public.*.id,
  ]
}

output "aws_route_table_private" {
  value = [
    aws_route_table.route_tbl_private.*.id,
  ]
}

output "aws_route_table_associaton_public" {
  value = aws_route_table_association.route_tbl_assoc_public.*.id
}

output "aws_route_table_associaton_private" {
  value = aws_route_table_association.route_tbl_assoc_private.*.id
}

output "bastion_instance_id" {
  value = aws_instance.bastion.id
}

output "bastion_private_ip" {
  value = aws_instance.bastion.private_ip
}

output "basiton_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "bastion_public_dns" {
  value = aws_instance.bastion.public_dns
}

output "bastion_sg_id" {
  value = aws_security_group.bastion_sg.id
}
