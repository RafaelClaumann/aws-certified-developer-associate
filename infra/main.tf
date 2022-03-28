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
