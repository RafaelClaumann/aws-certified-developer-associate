output "vpc_id" {
  value = aws_vpc.this.id
}

##########################
# public subnets outputs #
##########################
output "public_subnet_one_id" {
  value = aws_subnet.public_subnet_one.id
}

output "public_subnet_one_zone" {
  value = aws_subnet.public_subnet_one.availability_zone
}

output "public_subnet_two_id" {
  value = aws_subnet.public_subnet_two.id
}

output "public_subnet_two_zone" {
  value = aws_subnet.public_subnet_two.availability_zone
}

###########################
# private subnets outputs #
###########################
output "private_subnet_one_id" {
  value = aws_subnet.private_subnet_one.id
}

output "private_subnet_one_zone" {
  value = aws_subnet.private_subnet_one.availability_zone
}

output "private_subnet_two_id" {
  value = aws_subnet.private_subnet_two.id
}

output "private_subnet_two_zone" {
  value = aws_subnet.private_subnet_two.availability_zone
}

output "aws_internet_gateway_id" {
  value = aws_internet_gateway.this.id
}

output "aws_nat_gateway_id" {
  value = aws_nat_gateway.this.id
}

output "aws_eip_address" {
  value = aws_eip.this.address
}

output "aws_default_route_table_data" {
  value = aws_default_route_table.this.route
}

output "aws_route_table_data" {
  value = aws_route_table.this.route
}
