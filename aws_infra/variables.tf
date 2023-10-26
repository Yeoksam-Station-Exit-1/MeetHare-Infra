
variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-2"
}

variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type = list(string)
  default = ["ap-northeast-2a", "ap-northeast-2c"]
}

variable "cluster_name" {
  description = "Cluster Name"
  type = string
  default = "MeetHares"
}

variable "cluster_version" {
  description = "Cluster Version"
  type = string
  default = "1.28"
}

variable "vpc_cidr" {
  description = "VPC CIDR Range"
  type = string
  default = "192.168.0.0/16"
}

variable "vpc_name" {
  description = "VPC Name"
  type = string
  default = "MeetHare-VPC"
}

variable "istio-namespace" {
  description = "Namespace for istio"
  type = string
  default = "istio-system"
}

variable "istio_ingress_min_pods" {
  description = "Number of min pods of istio ingress"
  type = number
  default = 1
}

variable "istio_ingress_max_pods" {
  description = "Number of max pods of istio ingress"
  type = number
  default = 1
}