# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
resource "aws_vpc" "custom-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name    = "custom-vpc"
    Course  = "AWS Certified Solutions Architect Professional SAP-C01 2022"
    Session = "Advanced VPC"
    Class   = "3. [HOL] Create a Custom VPC with Subnets"
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_route_table
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/main_route_table_association
# Note that the default route, mapping the VPC's CIDR block to "local", is created implicitly and cannot be specified.
resource "aws_default_route_table" "custom-vpc-main-route-table" {
  default_route_table_id = aws_vpc.custom-vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.custom-vpc-igw.id
  }

  tags = {
    Name    = "custom-vpc-main-route-table"
    Course  = "AWS Certified Solutions Architect Professional SAP-C01 2022"
    Session = "Advanced VPC"
    Class   = "5. [HOL] Configure Routing"
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet#example-usage
resource "aws_subnet" "public-us-east-1a" {
  vpc_id            = aws_vpc.custom-vpc.id
  cidr_block        = "10.0.0.0/20"
  availability_zone = "us-east-1a"

  map_public_ip_on_launch = true

  tags = {
    Name    = "public-us-east-1a"
    Course  = "AWS Certified Solutions Architect Professional SAP-C01 2022"
    Session = "Advanced VPC"
    Class   = "3. [HOL] Create a Custom VPC with Subnets"
  }
}

resource "aws_subnet" "public-us-east-1b" {
  vpc_id            = aws_vpc.custom-vpc.id
  cidr_block        = "10.0.16.0/20"
  availability_zone = "us-east-1b"

  map_public_ip_on_launch = true

  tags = {
    Name    = "public-us-east-1b"
    Course  = "AWS Certified Solutions Architect Professional SAP-C01 2022"
    Session = "Advanced VPC"
    Class   = "3. [HOL] Create a Custom VPC with Subnets"
  }
}

resource "aws_subnet" "private-us-east-1a" {
  vpc_id            = aws_vpc.custom-vpc.id
  cidr_block        = "10.0.32.0/20"
  availability_zone = "us-east-1a"

  map_public_ip_on_launch = false

  tags = {
    Name    = "private-us-east-1a"
    Course  = "AWS Certified Solutions Architect Professional SAP-C01 2022"
    Session = "Advanced VPC"
    Class   = "3. [HOL] Create a Custom VPC with Subnets"
  }
}

resource "aws_subnet" "private-us-east-1b" {
  vpc_id            = aws_vpc.custom-vpc.id
  cidr_block        = "10.0.48.0/20"
  availability_zone = "us-east-1b"

  map_public_ip_on_launch = false

  tags = {
    Name    = "private-us-east-1b"
    Course  = "AWS Certified Solutions Architect Professional SAP-C01 2022"
    Session = "Advanced VPC"
    Class   = "3. [HOL] Create a Custom VPC with Subnets"
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
resource "aws_internet_gateway" "custom-vpc-igw" {
  vpc_id = aws_vpc.custom-vpc.id

  tags = {
    Name    = "custom-vpc-igw"
    Course  = "AWS Certified Solutions Architect Professional SAP-C01 2022"
    Session = "Advanced VPC"
    Class   = "5. [HOL] Configure Routing"
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
# Note that the default route, mapping the VPC's CIDR block to "local", is created implicitly and cannot be specified.
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.custom-vpc.id

  tags = {
    Name    = "private-route-table"
    Course  = "AWS Certified Solutions Architect Professional SAP-C01 2022"
    Session = "Advanced VPC"
    Class   = "5. [HOL] Configure Routing"
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association
resource "aws_route_table_association" "associate-private-us-east-1a" {
  subnet_id      = aws_subnet.private-us-east-1a.id
  route_table_id = aws_route_table.private-route-table.id
}

resource "aws_route_table_association" "associate-private-us-east-1b" {
  subnet_id      = aws_subnet.private-us-east-1b.id
  route_table_id = aws_route_table.private-route-table.id
}
