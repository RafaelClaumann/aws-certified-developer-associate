output "vpc_id" {
  value = module.network.vpc_id
}

output "aws_internet_gateway_id" {
  value = module.network.aws_internet_gateway_id
}

##########################
# public subnets outputs #
##########################
output "public_subnet_one_id" {
  value = module.network.public_subnet_one_id
}

output "public_subnet_one_zone" {
  value = module.network.public_subnet_one_zone
}

output "public_subnet_two_id" {
  value = module.network.public_subnet_two_id
}

output "public_subnet_two_zone" {
  value = module.network.public_subnet_two_zone
}

###########################
# private subnets outputs #
###########################
output "private_subnet_one_id" {
  value = module.network.private_subnet_one_id
}

output "private_subnet_one_zone" {
  value = module.network.private_subnet_one_zone
}

output "private_subnet_two_id" {
  value = module.network.private_subnet_two_id
}

output "private_subnet_two_zone" {
  value = module.network.private_subnet_two_zone
}

########################
# route tables outputs #
########################
output "aws_default_route_table_data" {
  value = module.network.aws_default_route_table_data
}

output "aws_route_table_data" {
  value = module.network.aws_route_table_data
}
