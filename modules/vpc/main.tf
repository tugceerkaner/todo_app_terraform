# create vpc
resource "aws_vpc" "vpc" {
  cidr_block = var.VPC_CIDR
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true
  enable_classiclink   = false
  enable_classiclink_dns_support = false
  assign_generated_ipv6_cidr_block = false
  tags = { # tags to assign to the resource
    Name = "${var.PROJECT_NAME}-VPC"
  }
}

# create internet gateway and attach it to vpc
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.PROJECT_NAME}-IGW"
  }
}

# data source is used to get available availability zones on the specified region
data "aws_availability_zones" "availability_zones" {}

# create first public subnet
resource "aws_subnet" "subnet_pub_sub1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.PUB_SUB1_CIDR
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.availability_zones.names[0]
  tags = {
    Name = "subnet_pub_sub1"
    "kubernetes.io/cluster/${var.PROJECT_NAME}" = "shared"
    "kubernetes.io/role/elb" = 1
  }
}

# create second public subnet
resource "aws_subnet" "subnet_pub_sub2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.PUB_SUB2_CIDR
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.availability_zones.names[1]
  tags = {
    Name = "subnet_pub_sub2"
    "kubernetes.io/cluster/${var.PROJECT_NAME}" = "shared"
    "kubernetes.io/role/elb" = 1
  }
}

# create route table for public subnets
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = {
    Name = "${var.PROJECT_NAME}-RT"
  }
}

# associate first public subnet to route table
resource "aws_route_table_association" "route_table_association_first" {
  route_table_id = aws_route_table.route_table.id
  subnet_id = aws_subnet.subnet_pub_sub1.id
}

# associate second public subnet to route table
resource "aws_route_table_association" "route_table_association_second" {
  route_table_id = aws_route_table.route_table.id
  subnet_id = aws_subnet.subnet_pub_sub2.id
}

# create first private subnet
resource "aws_subnet" "subnet_pri_sub3" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.PRI_SUB3_CIDR
  map_public_ip_on_launch = false
  availability_zone = data.aws_availability_zones.availability_zones.names[0]
  tags = {
    Name = "subnet_pri_sub3"
    "kubernetes.io/cluster/${var.PROJECT_NAME}" = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}
# create second private subnet
resource "aws_subnet" "subnet_pri_sub4" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.PRI_SUB4_CIDR
  map_public_ip_on_launch = false
  availability_zone = data.aws_availability_zones.availability_zones.names[1]
  tags = {
    Name = "subnet_pri_sub4"
    "kubernetes.io/cluster/${var.PROJECT_NAME}" = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}