terraform {
  backend "s3" {
    bucket = "groupF-eks-infra-tfstate"
    key = "backend/groupF-gitops-project.tfstate"
    region = "us-east-1"
    dynamodb_table = "groupF-dynamoDB"
  }
}