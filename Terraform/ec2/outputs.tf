
output "jenkins_public_ip" {
  value = aws_instance.jenkins.public_ip
}

output "myapp_public_ip" {
  value = aws_instance.myapp.public_ip
}
