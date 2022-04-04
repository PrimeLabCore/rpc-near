variable "region" {
  type        = string
  description = "Name of region for deployment."
  default     = "us-east-1"
}

variable "environment" {
  type        = string
  description = "Name of Environment for deployment."
  default     = null
}

variable "vpc_cidr" {
  description = "VPC Cidr Block"
  type        = string
  default     = null
}

variable "azs" {
  description = "AZ's for the VPC"
  type        = list(string)
  default     = []
}

variable "private_subnets" {
  description = "Private Subnets for the VPC"
  type        = list(string)
  default     = []
}

variable "public_subnets" {
  description = "Public Subnets for the VPC"
  type        = list(string)
  default     = []
}

variable "database_subnets" {
  description = "Database Subnets for the VPC"
  type        = list(string)
  default     = []
}

variable "ecs_asg_max_size" {
  description = "EC2 Capacity Providers ASG - Max Number of Instances"
  type        = number
  default     = 1
}

variable "ecs_asg_min_size" {
  description = "EC2 Capacity Providers ASG - Min Number of Instances"
  type        = number
  default     = 1
}

variable "ecs_asg_desired_capacity" {
  description = "EC2 Capacity Providers ASG - Min Number of Instances"
  type        = number
  default     = 1
}

variable "ecs_instance_type" {
  description = "Instance Type for ECS Cluster"
  type        = string
  default     = "c5.4xlarge"
}

variable "docker_tag" {
  default = ""
}

variable "rpc_node_cpu" {
  description = "ECS Container - RPC Node CPU"
  type        = number
  default     = 4096
}

variable "rpc_node_ram" {
  description = "ECS Container - RPC Node RAM"
  type        = number
  default     = 16384
}

variable "ecr_subrepositories" {
  description = "The Sub-Repositories for each of the node types"
  type        = list(string)
  default     = []
}

variable "primelab_nodes" {
  description = "Primelab Node Parameters"
  default = {
    "rpc" = {
      "dockerTag"  = ""
      "dockerRepo" = 0
    }
  }
}

variable "container_name" {
  description = "RPC Container name"
  default     = "rpc_node"
}

