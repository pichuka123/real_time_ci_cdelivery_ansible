
resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = var.public_key
}


# ------------------------- SECURITY GROUP for JENKINS -------------------------

resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-sg"
  vpc_id      = var.vpc_id
  description = "SG for Jenkins Server"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "jenkins-sg" }

}


# ------------------------- SECURITY GROUP for MyApp -------------------------

resource "aws_security_group" "myapp_sg" {
  name        = "myapp-sg"
  vpc_id      = var.vpc_id   # ✅ Use variable instead of aws_vpc.prod.id
  description = "MyApp SG"

  ingress {
  description = "MyApp HTTP"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
 }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "All Inbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "myapp-sg" }
}



# ------------------------- JENKINS INSTANCE -------------------------

resource "aws_instance" "jenkins" {
  ami           = "ami-0fa3fe0fa7920f68e"
  instance_type = "t2.large"
  subnet_id     = var.public_subnet_id
  key_name      = aws_key_pair.key_pair.key_name
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  associate_public_ip_address = true  # ✅ Ensure public IP is assigned
  
connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.private_key_path)
  }


  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo",
      "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key",
      "sudo yum install wget git maven ansible docker jenkins -y",
      "sudo systemctl enable jenkins && sudo systemctl start jenkins",
      "sudo systemctl enable docker && sudo systemctl start docker",
      "sudo usermod -aG docker ec2-user",
      "sudo usermod -aG docker jenkins",
      "sudo chmod 666 /var/run/docker.sock",
      "sudo docker run -d --name sonar -p 9000:9000 sonarqube",
      "sudo rpm -ivh https://github.com/aquasecurity/trivy/releases/download/v0.18.3/trivy_0.18.3_Linux-64bit.rpm"
    ]
  }

  tags = { Name = "Jenkins-by-Terraform" }
}


# ------------------------- MyApp Instance -------------------------

resource "aws_instance" "myapp" {
  ami                    = "ami-0fa3fe0fa7920f68e"
  instance_type          = "t2.micro"
  subnet_id              = var.public_subnet_id   # ✅ Use variable instead of aws_subnet.public_subnet.id
  key_name               = aws_key_pair.key_pair.key_name
  vpc_security_group_ids = [aws_security_group.myapp_sg.id]
  tags = { Name = "MyApp-by-Terraform" }
}
