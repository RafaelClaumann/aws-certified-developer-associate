output "vpc_id" {
  value = aws_vpc.custom-vpc.id
}

output "public_us-east-1a_id" {
  value = aws_subnet.public-us-east-1a.id
}

output "public_us-east-1b_id" {
  value = aws_subnet.public-us-east-1b.id
}

output "private_us-east-1a_id" {
  value = aws_subnet.private-us-east-1a.id
}

output "private_us-east-1b_id" {
  value = aws_subnet.private-us-east-1b.id
}

output "public-ec2-instance-ip" {
  value = aws_instance.public-ubuntu.public_ip
}

output "private-ec2-instance-ip" {
  value = aws_instance.private-ubuntu.private_ip
}
