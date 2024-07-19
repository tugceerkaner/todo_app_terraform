terraform {
  backend "s3" {
    bucket = "group-f-eks-infra-tfstate"
    key = "backend/group-f-gitops-project.tfstate"
    region = "us-east-1"
    dynamodb_table = "group-f-dynamoDB"
  }
}