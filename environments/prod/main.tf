provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "../../modules/vpc"
}

module "s3" {
  source = "../../modules/s3"
}

module "alb" {
  source     = "../../modules/alb"
  subnet_ids = module.vpc.public_subnet_ids
  vpc_id     = module.vpc.vpc_id
  alb_sg_id  = module.vpc.alb_sg_id
}

module "ec2" {
  source      = "../../modules/ec2"
  subnet_ids  = module.vpc.public_subnet_ids
  ami_id      = var.ami_id
  key_name    = var.key_name
  ec2_sg_id   = module.vpc.ec2_sg_id
}

module "rds" {
  source             = "../../modules/rds"
  db_username        = var.db_username
  db_password        = var.db_password
  private_subnet_ids = module.vpc.private_subnet_ids
  rds_sg_id          = module.vpc.rds_sg_id
}
