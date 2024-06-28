# allocate elastic ip for the nat gateway in the first public subnet
resource "aws_eip" "eip_natGW1" {
  vpc = true
  tags = {
    Name = "eip_natGW1"
  }
}

# allocate elastic ip for the nat gateway in the second public subnet
resource "aws_eip" "eip_natGW2" {
  vpc = true
  tags = {
    Name = "eip_natGW2"
  }
}

# create first nat gateway
resource "aws_nat_gateway" "nat_gateway_first" {
    subnet_id = var.PUB_SUB1_ID
    allocation_id = aws_eip.eip_natGW1.id
    tags = {
        Name = "nat_gateway_first"
    }
    depends_on = [var.IGW_ID] # nat gateway is dependent to igw, so igw has to be created first
}

# create second nat gateway
resource "aws_nat_gateway" "nat_gateway_second" {
    subnet_id = var.PUB_SUB2_ID
    allocation_id = aws_eip.eip_natGW2.id
    tags = {
        Name = "nat_gateway_second"
    }
    depends_on = [var.IGW_ID] 
}

# create route table for first private subnet
resource "aws_route_table" "route_table_pri_sub3" {
  vpc_id = var.VPC_ID
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_first.id
  }
  tags = {
    Name = "route_table_pri_sub3"
  }
}

# associate first private subnet with route table
resource "aws_route_table_association" "route_table_association_pri_sub3" {
  route_table_id = aws_route_table.route_table_pri_sub3.id
  subnet_id = var.PRI_SUB3_ID
}

# create route table for second private subnet
resource "aws_route_table" "route_table_pri_sub4" {
  vpc_id = var.VPC_ID
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_second.id
  }
  tags = {
    Name = "route_table_pri_sub4"
  }
}

# associate second private subnet with route table
resource "aws_route_table_association" "route_table_association_pri_sub4" {
  route_table_id = aws_route_table.route_table_pri_sub4.id
  subnet_id = var.PRI_SUB4_ID
}

