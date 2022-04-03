# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway
resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = aws_subnet.public_subnet_one.id

  connectivity_type = "public"

  tags = {
    Name    = "custom-NAT-gateway"
    Course  = "AWS Certified Solutions Architect Professional SAP-C01 2022"
    Session = "Advanced VPC"
    Class   = "8. [HOL] Create NAT Gateway"
  }

  depends_on = [
    aws_eip.this
  ]
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip
resource "aws_eip" "this" {
  vpc = true
  depends_on = [
    aws_internet_gateway.this
  ]
}
