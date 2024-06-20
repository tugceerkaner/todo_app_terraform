# create vpc
resource "aws_vpc" "vpc" {
  cidr_block = var.VPC_CIDR
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true
  # enable_classiclink   = false
  # enable_classiclink_dns_support = false
  assign_generated_ipv6_cidr_block = false
  tags = { # tags to assign to the resource
    Name = "${var.PROJECT_NAME}-VPC"
  }
}
