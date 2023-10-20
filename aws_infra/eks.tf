
data "aws_caller_identity" "current" {}

locals {
  node_group_name        = "${var.cluster_name}-node-group"
  iam_role_policy_prefix = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access = true

  eks_managed_node_group_defaults = {
    
    ami_type = "AL2_x86_64"
    disk_size = 10
    instance_types = ["t3.medium"]
    vpc_security_group_ids = []
    iam_role_additional_policies = {"${module.iam_policy_autoscaling.name}" : "${local.iam_role_policy_prefix}/${module.iam_policy_autoscaling.name}"}
  }

  eks_managed_node_groups = {
    ("${var.cluster_name}-worker") = {

      min_size     = 1
      max_size     = 2
      desired_size = 1

      # kubectl get nodes --show-labels
      labels = {
        ondemand = "true"
      }

      tags = {
        "k8s.io/cluster-autoscaler/enabled" : "true"
        "k8s.io/cluster-autoscaler/${var.cluster_name}" : "true"
      }
    }

    ("${var.cluster_name}-database") = {

      instance_types = ["t3.medium"]

      min_size     = 1
      max_size     = 1
      desired_size = 1

      # kubectl get nodes --show-labels
      labels = {
        ondemand = "true"
      }

      tags = {
        "k8s.io/cluster-autoscaler/enabled" : "false"
        "k8s.io/cluster-autoscaler/${var.cluster_name}" : "false"
      }
    }
  }
}