module "vpc" {
  source = "./vpc"
  cluster_name = var.cluster_name
}

module "eks" {
  source       = "./eks"
  cluster_name = var.cluster_name
  subnet_ids   = module.vpc.public_subnets
  vpc_id       = module.vpc.vpc_id
}

module "ec2" {
  source           = "./ec2"
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnets[0]
  key_name         = var.key_name
  private_key_path = var.private_key_path
  public_key       = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCud4VWSKEfMJUUPoGtU8Le4mQRYe3JT/DG5KRpTtveVWbOvKbKG7KH32PLhCRJqFMz5yB+Fb/WBJ/BCSANlNG1LYaD0g7QUD+yWS2hYju2XCHOGCWqeOkFBCD7uBy4iVbdrEMPlZVpKGOFdcavfjNJ5jtt2FEvviUntVqVEY6UsllsM21UMxRu7dTivFcR25HCGC1doZUUxzhd6+kMVTB5vBuH0mV2FYnsD8qzpXHg05eBPnh35O44clBy9AyG4WI/aM5rktGK6iY6uHEUOWFQMCBq+nKeNcpPKd2tULX8uriWwLnShcg0U3sh6aGD6WKdernfFdoffanVi/4NCJHUeElllP14cQFx7ZdKonzpkfPfvHctNMWOXPtT9QKVmZ7Sf7+/2k9y+eZTQS3ljViwQMw0RhJKaMJKR+FAixQtj3MiMF+LtpSlAkE+Ne3dVHcpj+vIPlOmkVVuE/9rzw1PmyDtaxyhx1vOmWOKHhoc+ej/pnIPa/p4qN6YlMDP0ok= LSEG+pcharles1@PPC-D-DX2MX64"
}























