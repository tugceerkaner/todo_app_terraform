output "vpc_id" {
    value = aws_vpc.vpc.id
}
output "igw_id" {
    value = aws_internet_gateway.internet_gateway
}

output "pub_sub1_id" {
    value = aws_subnet.subnet_pub_sub1.id
}

output "pub_sub2_id" {
    value = aws_subnet.subnet_pub_sub2.id
}

output "pri_sub3_id" {
    value = aws_subnet.subnet_pri_sub3.id
}

output "pri_sub4_id" {
    value = aws_subnet.subnet_pri_sub4.id
}

# output "region" {
#   value = var.REGION
# }