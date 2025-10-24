# -------------------------------
# General AWS and Project Config
# -------------------------------
variable "aws_region" {
  description = "AWS region for all resources"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Project name prefix"
  type        = string
  default     = "devops-project"
}

# -------------------------------
# Networking Configuration
# -------------------------------
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  description = "CIDR for public subnet 1"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  description = "CIDR for public subnet 2"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet_1_cidr" {
  description = "CIDR for private subnet 1"
  type        = string
  default     = "10.0.3.0/24"
}

variable "private_subnet_2_cidr" {
  description = "CIDR for private subnet 2"
  type        = string
  default     = "10.0.4.0/24"
}

# -------------------------------
# Backend Microservice Ports
# -------------------------------
variable "backend_ports" {
  description = "Ports used by backend services"
  type        = list(number)
  default     = [5001, 5002, 5003, 5004, 5005, 5006]
}

# -------------------------------
# Database Configuration
# -------------------------------
variable "db_instance_class" {
  description = "RDS instance type"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "RDS storage size (GB)"
  type        = number
  default     = 20
}

variable "db_user" {
  description = "Database username"
  type        = string
  default     = "postgres"
}

variable "db_password" {
  description = "Database password"
  type        = string
  default     = "12345678"
}

# -------------------------------
# Dynamic Image Tags (from Jenkins)
# -------------------------------
variable "auth_image_tag" {
  description = "ECR image tag for auth service"
  type        = string
  default     = "latest"
}

variable "product_image_tag" {
  description = "ECR image tag for product service"
  type        = string
  default     = "latest"
}

variable "cart_image_tag" {
  description = "ECR image tag for cart service"
  type        = string
  default     = "latest"
}

variable "order_image_tag" {
  description = "ECR image tag for order service"
  type        = string
  default     = "latest"
}

variable "payment_image_tag" {
  description = "ECR image tag for payment service"
  type        = string
  default     = "latest"
}

variable "email_image_tag" {
  description = "ECR image tag for email service"
  type        = string
  default     = "latest"
}
