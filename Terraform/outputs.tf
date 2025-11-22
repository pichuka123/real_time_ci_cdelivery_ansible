output "public_ip_jenkins" {
  description = "Public IP of the Jenkins EC2 instance"
  value       = aws_instance.jenkins.public_ip
}

output "public_ip_app" {
  description = "Public IP of the MyApp EC2 instance"
  value       = aws_instance.myapp.public_ip
}
<<<<<<< HEAD


output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "vpc_id" {
  value = module.vpc.vpc_id
}
=======
>>>>>>> 69021f93c4f94309fb39b4924c235ea97aeaccbf
