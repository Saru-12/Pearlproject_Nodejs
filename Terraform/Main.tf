provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./vpc"
}

module "ecr" {
  source = "./ecr"
  app_name = var.app_name
}

module "ecs" {
  source = "./ecs"
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.subnet_ids
  security_group_id = module.vpc.security_group_id
  ecr_repo_url = module.ecr.ecr_repo_url
  app_name = var.app_name
  container_port = 3000
}

output "ecs_cluster_id" {
  value = module.ecs.cluster_id
}
