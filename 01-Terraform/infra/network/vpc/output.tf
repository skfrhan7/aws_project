output "vpc_id" {
    value = aws_vpc.aws05_vpc.id
}

# output "public_subnet_arns" {
#    value = aws_vpc.aws05_public_subnet_arns
# }

output "public_subnet2a" {
    value = aws_subnet.aws05_public_subnet2a.id
}
output "public_subnet2c" {
    value = aws_subnet.aws05_public_subnet2c.id
}
output "private_subnet2a" {
    value = aws_subnet.aws05_private_subnet2a.id
}
output "private_subnet2c" {
    value = aws_subnet.aws05_private_subnet2c.id
}

