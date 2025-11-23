
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for EKS"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID for EKS cluster"
  type        = string
}
