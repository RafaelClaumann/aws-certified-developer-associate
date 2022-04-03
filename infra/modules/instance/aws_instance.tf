resource "aws_instance" "this_private" {
  ami           = data.aws_ami.ubuntu_ami.image_id
  instance_type = "t2.micro"

  key_name = aws_key_pair.this_private.key_name

  subnet_id                   = var.private_subnet_id
  availability_zone           = var.private_subnet_availability_zone
  vpc_security_group_ids      = [aws_security_group.internal-ssh-sg.id]
  associate_public_ip_address = false

  tags = {
    Name    = "private-ubuntu-instance"
    Course  = "AWS Certified Solutions Architect Professional SAP-C01 2022"
    Session = "Advanced VPC"
    Class   = "8. [HOL] Create NAT Gateway"
  }
}

resource "aws_instance" "this_public" {
  ami           = data.aws_ami.ubuntu_ami.image_id
  instance_type = "t2.micro"

  key_name = aws_key_pair.this_public.key_name

  subnet_id                   = var.public_subnet_id
  availability_zone           = var.public_subnet_availability_zone
  vpc_security_group_ids      = [aws_security_group.external-ssh-sg.id]
  associate_public_ip_address = true

  tags = {
    Name    = "public-ubuntu-instance"
    Course  = "AWS Certified Solutions Architect Professional SAP-C01 2022"
    Session = "Advanced VPC"
    Class   = "8. [HOL] Create NAT Gateway"
  }
}
