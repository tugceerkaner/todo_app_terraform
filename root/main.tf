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