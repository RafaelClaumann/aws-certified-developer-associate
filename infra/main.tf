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

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name    = "private-route-table"
    Course  = "AWS Certified Solutions Architect Professional SAP-C01 2022"
    Session = "Advanced VPC"
    Class   = "5. [HOL] Configure Routing"
  }

  depends_on = [
    aws_nat_gateway.nat-gw
  ]
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

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
# By default, AWS creates an ALLOW ALL egress rule when creating a new Security Group inside of a VPC.
# When creating a new Security Group inside a VPC, Terraform will remove this default rule, and require
# you specifically re-create it if you desire that rule. 
resource "aws_security_group" "external-ssh-sg" {
  name        = "external-ssh-access"
  description = "Allow external SSH inbound traffic to EC2"
  vpc_id      = aws_vpc.custom-vpc.id

  ingress {
    description      = "Allow SSH to public EC2 instances"
    from_port        = 22
    to_port          = 22
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name    = "external-ssh-sg"
    Course  = "AWS Certified Solutions Architect Professional SAP-C01 2022"
    Session = "Advanced VPC"
    Class   = "6. [HOL] Setup Security Groups and NACLs"
  }
}

resource "aws_security_group" "internal-ssh-sg" {
  name        = "interal-ssh-access"
  description = "Allow internal SSH inbound traffic to EC2 from ${aws_security_group.external-ssh-sg.id}"
  vpc_id      = aws_vpc.custom-vpc.id

  ingress {
    description     = "Allow SSH to Internal EC2 Instances"
    from_port       = 22
    to_port         = 22
    protocol        = "TCP"
    security_groups = ["${aws_security_group.external-ssh-sg.id}"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name    = "internal-ssh-sg"
    Course  = "AWS Certified Solutions Architect Professional SAP-C01 2022"
    Session = "Advanced VPC"
    Class   = "6. [HOL] Setup Security Groups and NACLs"
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip
resource "aws_eip" "elastic-ip" {
  vpc = true
  depends_on = [
    aws_internet_gateway.custom-vpc-igw
  ]
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway
resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.elastic-ip.id
  subnet_id     = aws_subnet.public-us-east-1a.id

  connectivity_type = "public"

  tags = {
    Name    = "custom-NAT-gateway"
    Course  = "AWS Certified Solutions Architect Professional SAP-C01 2022"
    Session = "Advanced VPC"
    Class   = "8. [HOL] Create NAT Gateway"
  }

  depends_on = [
    aws_eip.elastic-ip
  ]
}
