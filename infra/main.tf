provider "aws" {
  region  = "us-east-1"
  profile = "terraform-cli-user"
}

module "network" {
  source = "./modules/vpc"

  vpc_cidr = "10.0.0.0/16"

  subnets_az_us_east_1a = "us-east-1a"
  subnets_az_us_east_1b = "us-east-1b"

  public_subnet_one_cidr = "10.0.0.0/20"
  public_subnet_two_cidr = "10.0.16.0/20"

  private_subnet_one_cidr = "10.0.32.0/20"
  private_subnet_two_cidr = "10.0.48.0/20"
}
