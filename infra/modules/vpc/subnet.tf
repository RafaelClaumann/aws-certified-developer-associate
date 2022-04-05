# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet#example-usage
resource "aws_subnet" "public_subnet_one" {
  vpc_id            = aws_vpc.this.id
  availability_zone = var.subnets_az_us_east_1a
  cidr_block        = var.public_subnet_one_cidr

  map_public_ip_on_launch = true

  tags = {
    Name    = "public-${var.subnets_az_us_east_1a}"
    Course  = "AWS Certified Solutions Architect Professional SAP-C01 2022"
    Session = "Advanced VPC"
    Class   = "3. [HOL] Create a Custom VPC with Subnets"
  }
}

resource "aws_subnet" "public_subnet_two" {
  vpc_id            = aws_vpc.this.id
  availability_zone = var.subnets_az_us_east_1b
  cidr_block        = var.public_subnet_two_cidr

  map_public_ip_on_launch = true

  tags = {
    Name    = "public-${var.subnets_az_us_east_1b}"
    Course  = "AWS Certified Solutions Architect Professional SAP-C01 2022"
    Session = "Advanced VPC"
    Class   = "3. [HOL] Create a Custom VPC with Subnets"
  }
}

resource "aws_subnet" "private_subnet_one" {
  vpc_id            = aws_vpc.this.id
  availability_zone = var.subnets_az_us_east_1a  
  cidr_block        = var.private_subnet_one_cidr

  map_public_ip_on_launch = false

  tags = {
    Name    = "private-${var.subnets_az_us_east_1a}"
    Course  = "AWS Certified Solutions Architect Professional SAP-C01 2022"
    Session = "Advanced VPC"
    Class   = "3. [HOL] Create a Custom VPC with Subnets"
  }
}

resource "aws_subnet" "private_subnet_two" {
  vpc_id            = aws_vpc.this.id
  availability_zone = var.subnets_az_us_east_1b  
  cidr_block        = var.private_subnet_two_cidr

  map_public_ip_on_launch = false

  tags = {
    Name    = "private-${var.subnets_az_us_east_1b}"
    Course  = "AWS Certified Solutions Architect Professional SAP-C01 2022"
    Session = "Advanced VPC"
    Class   = "3. [HOL] Create a Custom VPC with Subnets"
  }
}
