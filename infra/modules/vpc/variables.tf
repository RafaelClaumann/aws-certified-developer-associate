variable "vpc_cidr" {
  type = string
}

variable "subnets_az_us_east_1a" {
  type = string
  default = "us-east-1a"
}

variable "subnets_az_us_east_1b" {
  type = string
  default = "us-east-1b"
}

variable "public_subnet_one_cidr" {
  type = string
}

variable "public_subnet_two_cidr" {
  type = string
}

variable "private_subnet_one_cidr" {
  type = string
}

variable "private_subnet_two_cidr" {
  type = string
}
