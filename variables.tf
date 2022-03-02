variable "availability_zone" {
  type    = string
  default = "us-east-1a"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "instance_type" {
  type    = string
  default = "c5.2xlarge"
}

variable "ami" {
  type    = string
  default = "ami-0069be05df48d3678"
}

variable "key_name" {
  type    = string
  default = "testnet.pem"
}

variable "profile" {
  type    = string
  default = "cloud-account-administrator-361205757716"
}
