output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "vpc_id" {
  value = module.vpc.vpc_id
}


output "jenkins_public_ip" {
  value = module.ec2.jenkins_public_ip
}

output "myapp_public_ip" {
  value = module.ec2.myapp_public_ip
}

