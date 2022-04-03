# é preciso gerar um par de chaves com nome key e private-instance-key.pub na pasta ~/.aws/ec2-ssh 
# basta executar o comando(ssh-keygen -q -t rsa -f private-instance-key -N '') na pasta .aws/ec2-ssh
# sudo scp -i public-instance-key private-instance-* ubuntu@<machine-ip>:./
# ssh -i private-instance-key ubuntu@<ip>
# ping www.google.com
resource "aws_key_pair" "this_private" {
  key_name   = "private-instance-key"
  public_key = file("~/.aws/ec2-ssh/private-instance-key.pub")
}

# é preciso gerar um par de chaves com nome key e public-instance-key.pub na pasta ~/.aws/ec2-ssh 
# basta executar o comando(ssh-keygen -q -t rsa -f public-instance-key -N '') na pasta .aws/ec2-ssh
# ssh -i public-instance-key ubuntu@<ip>
resource "aws_key_pair" "this_public" {
  key_name   = "public-instance-key"
  public_key = file("~/.aws/ec2-ssh/public-instance-key.pub")
}
