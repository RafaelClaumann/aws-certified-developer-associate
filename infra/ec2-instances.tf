# https://registry.terraform.io/providers/hashicorp/aws/latest/docs
data "aws_ami" "ubuntu_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}

# é preciso gerar um par de chaves com nome key e public-instance-key.pub na pasta ~/.aws/ec2-ssh 
# basta executar o comando(ssh-keygen -q -t rsa -f public-instance-key -N '') na pasta .aws/ec2-ssh
# ssh -i public-instance-key ubuntu@<ip>
resource "aws_key_pair" "public-ssh-key" {
  key_name   = "public-instance-key"
  public_key = file("~/.aws/ec2-ssh/public-instance-key.pub")
}

resource "aws_instance" "public-ubuntu" {
  ami           = data.aws_ami.ubuntu_ami.image_id
  instance_type = "t2.micro"

  key_name = aws_key_pair.public-ssh-key.key_name

  availability_zone           = aws_subnet.public-us-east-1a.availability_zone
  subnet_id                   = aws_subnet.public-us-east-1a.id
  vpc_security_group_ids      = [aws_security_group.external-ssh-sg.id]
  associate_public_ip_address = true

  tags = {
    Name    = "public-ubuntu-instance"
    Course  = "AWS Certified Solutions Architect Professional SAP-C01 2022"
    Session = "Advanced VPC"
    Class   = "8. [HOL] Create NAT Gateway"
  }
}

# é preciso gerar um par de chaves com nome key e private-instance-key.pub na pasta ~/.aws/ec2-ssh 
# basta executar o comando(ssh-keygen -q -t rsa -f private-instance-key -N '') na pasta .aws/ec2-ssh
# sudo scp -i public-instance-key private-instance-* ubuntu@<machine-ip>:./
# ssh -i private-instance-key ubuntu@<ip>
# ping www.google.com
resource "aws_key_pair" "private-ssh-key" {
  key_name   = "private-instance-key"
  public_key = file("~/.aws/ec2-ssh/private-instance-key.pub")
}

resource "aws_instance" "private-ubuntu" {
  ami           = data.aws_ami.ubuntu_ami.image_id
  instance_type = "t2.micro"

  key_name = aws_key_pair.private-ssh-key.key_name

  availability_zone           = aws_subnet.private-us-east-1a.availability_zone
  subnet_id                   = aws_subnet.private-us-east-1a.id
  vpc_security_group_ids      = [aws_security_group.internal-ssh-sg.id]
  associate_public_ip_address = false

  tags = {
    Name    = "private-ubuntu-instance"
    Course  = "AWS Certified Solutions Architect Professional SAP-C01 2022"
    Session = "Advanced VPC"
    Class   = "8. [HOL] Create NAT Gateway"
  }
}