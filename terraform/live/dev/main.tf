module "vpc" {
  source = "../../modules/vpc"

  project_name       = "foodbyte"
  environment        = "dev"
  vpc_cidr          = "10.0.0.0/16"
  availability_zones = ["us-east-1a", "us-east-1b"]
}

module "eks" {
  source = "../../modules/eks"

  project_name       = "foodbyte"
  environment        = "dev"
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids

  depends_on = [module.vpc]
}

module "db" {
  source = "../../modules/db"

  project_name      = "foodbyte"
  environment       = "dev"
  vpc_id            = module.vpc.vpc_id
  intra_subnet_ids  = module.vpc.intra_subnet_ids
  eks_cluster_sg_id = module.eks.cluster_security_group_id
  
  # For learning/demo, we pass a hardcoded password. 
  # In a real company, this would come from a secret manager.
  db_password       = "FoodByteSuperSecure2026"

  depends_on = [module.eks]
}
