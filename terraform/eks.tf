module "ping-pong" {
  source                         = "terraform-aws-modules/eks/aws"
  version                        = "~> 19.13"
  cluster_name                   = var.eks-cluster-name
  cluster_version                = "1.24"
  vpc_id                         = module.eks-vpc.vpc_id
  subnet_ids                     = module.eks-vpc.private_subnets
  cluster_endpoint_public_access = true
  cluster_ip_family              = "ipv4"
  cluster_enabled_log_types      = ["audit", "authenticator", "controllerManager", "scheduler"]
  tags                           = local.tags
  kms_key_enable_default_policy  = true
  eks_managed_node_group_defaults = {
    ami_type      = "AL2_x86_64"
    capacity_type = "ON_DEMAND"
    update_config = { "max_unavailable" : 1 }
  }
  cluster_security_group_additional_rules = {
    external_https = {
      from_port   = 443
      to_port     = 443
      type        = "ingress"
      protocol    = "tcp"
      description = "enable external API call"
      cidr_blocks = "0.0.0.0/0"
    }
  }
  node_security_group_additional_rules = {
    internal_nodeport = {
      from_port   = 30000
      to_port     = 32767
      type        = "ingress"
      protocol    = "tcp"
      description = "internal nodeport traffic"
      cidr_blocks = [module.eks-vpc.vpc_cidr_block]
    }
    mt_internal_kubelet = {
      from_port   = 10250
      to_port     = 10250
      type        = "ingress"
      protocol    = "tcp"
      description = "internal port-forward"
      cidr_blocks = [module.eks-vpc.vpc_cidr_block]
    }
  }
  cluster_encryption_policy_use_name_prefix = false
  eks_managed_node_groups = {
    general = {
      use_name_prefix = true
      desired_size    = var.eks-nodes-desired-size
      min_size        = var.eks-nodes-min-size
      max_size        = var.eks-nodes-max-size
      instance_types  = [var.eks-node-type]
      subnet_ids      = module.eks-vpc.private_subnets
      block_device_mappings = {
        root = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size = var.eks-node-disk-size
            volume_type = var.eks-node-disk-type
          }
        }
      }
    }
  }
  create_aws_auth_configmap = false
  manage_aws_auth_configmap = false

  cluster_addons = {
    coredns = {
      addon_version = "v1.8.7-eksbuild.3"
    }
    kube-proxy = {
      addon_version = "v1.24.7-eksbuild.2"
    }
    vpc-cni = {
      addon_version = "v1.11.4-eksbuild.1"
    }
  }
}
