
provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Terraform = "true"
      Project   = "${var.cluster_name}-project"
    }
  }
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
}

provider "helm" {

  kubernetes {
    
    config_path = "~/.kube/config"
  }
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.name]
    command     = "aws"
  }
}

# data "kubernetes_service" "nginx" {
#   depends_on = [helm_release.nginx]
#   metadata {
#     name = "nginx"
#   }
# }

terraform {

  backend "s3" {
    
    bucket         = "meethare-infra-tfstate"
    key            = "dev/terraform.tfstate"
    region         = "ap-northeast-2"
    
    dynamodb_table = "terraform-locks"
    # encrypt        = true
  }

  required_providers {
    helm = {
      source  = "hashicorp/helm"
    }
  }
}