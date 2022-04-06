# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_route_table
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/main_route_table_association
# Note that the default route, mapping the VPC's CIDR block to "local", is created implicitly and cannot be specified.
resource "aws_default_route_table" "this" {
  default_route_table_id = aws_vpc.this.main_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name    = "custom-vpc-main-route-table"
    Course  = "AWS Certified Solutions Architect Professional SAP-C01 2022"
    Session = "Advanced VPC"
    Class   = "5. [HOL] Configure Routing"
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
# Note that the default route, mapping the VPC's CIDR block to "local", is created implicitly and cannot be specified.
resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name    = "private-route-table"
    Course  = "AWS Certified Solutions Architect Professional SAP-C01 2022"
    Session = "Advanced VPC"
    Class   = "5. [HOL] Configure Routing"
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association
resource "aws_route_table_association" "this_private_subnet_one" {
  subnet_id      = aws_subnet.private_subnet_one.id
  route_table_id = aws_route_table.this.id
}

resource "aws_route_table_association" "this_private_subnet_two" {
  subnet_id      = aws_subnet.private_subnet_two.id
  route_table_id = aws_route_table.this.id
}
