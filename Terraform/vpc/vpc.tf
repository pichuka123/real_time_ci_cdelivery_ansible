
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "eks-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]   # ✅ Two AZs
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]   # ✅ One subnet per AZ
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]


  enable_nat_gateway = true
  single_nat_gateway = true
  map_public_ip_on_launch = true

  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}
