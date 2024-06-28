module "vpc" {
    source =  "../modules/vpc"
    REGION = var.region
    PROJECT_NAME = var.project_name
    VPC_CIDR = var.vpc_cidr
    PUB_SUB1_CIDR = var.pub_sub1_cidr
    PUB_SUB2_CIDR = var.pub_sub2_cidr
    PRI_SUB3_CIDR = var.pri_sub3_cidr
    PRI_SUB4_CIDR = var.pri_sub4_cidr
}

module "natGW" {
    source = "../modules/natGW"
    IGW_ID = module.vpc.igw_id
    VPC_ID = module.vpc.id
    PUB_SUB1_ID = module.vpc.pub_sub1_id
    PUB_SUB2_ID = module.vpc.pub_sub2_id
    PRI_SUB3_ID = module.vpc.pri_sub3_id
    PRI_SUB4_ID = module.vpc.pri_sub4_id
}

module "iam" {
    source = "../modules/iam"
    PROJECT_NAME = var.project_name
}