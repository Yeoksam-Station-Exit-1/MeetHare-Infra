
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  azs  = var.azs
  cidr = var.vpc_cidr

  enable_nat_gateway   = true
  single_nat_gateway   = true
  # enable_dns_hostnames = true
  public_subnets = [for index in range(2):
                      cidrsubnet(var.vpc_cidr, 4, index)]

  private_subnets = [for index in range(2):
                      cidrsubnet(var.vpc_cidr, 4, index + 2)]
}

# Filter out local zones, which are not currently supported 
# with managed node groups
data "aws_availability_zones" "available" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}