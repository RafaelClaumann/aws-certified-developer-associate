# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
# By default, AWS creates an ALLOW ALL egress rule when creating a new Security Group inside of a VPC.
# When creating a new Security Group inside a VPC, Terraform will remove this default rule, and require
# you specifically re-create it if you desire that rule. 
resource "aws_security_group" "external-ssh-sg" {
  name        = "external-ssh-access"
  description = "Allow external SSH inbound traffic to EC2"
  vpc_id      = var.vpc_id

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
  vpc_id      = var.vpc_id

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
