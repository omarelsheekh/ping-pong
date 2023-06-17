variable "vpc-name" {
  type    = string
  default = "eks-vpc"
}

variable "vpc-cidr" {
  type    = string
  default = "10.50.0.0/16"
}

variable "vpc-azs" {
  type    = list(string)
  default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "vpc-private-cidrs" {
  type    = list(string)
  default = ["10.50.0.0/20", "10.50.16.0/20", "10.50.32.0/20"]
}

variable "vpc-public-cidrs" {
  type    = list(string)
  default = ["10.50.48.0/20", "10.50.64.0/20", "10.50.80.0/20"]
}

variable "eks-cluster-name" {
  type    = string
  default = "ping-pong"
}

variable "eks-nodes-min-size" {
  type    = number
  default = 2
}

variable "eks-nodes-max-size" {
  type    = number
  default = 2
}

variable "eks-nodes-desired-size" {
  type    = number
  default = 2
}

variable "eks-node-type" {
  type    = string
  default = "t3.medium"
}

variable "eks-node-disk-size" {
  type    = number
  default = 64
}

variable "eks-node-disk-type" {
  type    = string
  default = "gp3"
}