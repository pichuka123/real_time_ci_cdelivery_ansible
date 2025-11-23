
variable "region" {
  default = "us-east-1"
}

variable "cluster_name" {
  default = "eks-cluster"
}

variable "private_key_path" {
  description = "Path to your private key file"
  type        = string
}

variable "key_name" {
  description = "AWS key pair name"
  type = string 
}