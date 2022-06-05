output "security_group_web_id" {
  value = aws_security_group.app.id
}

output "security_group_vpc_id" {
  value = aws_security_group.vpc.id
}

output "subnet_public" {
  value = aws_subnet.public
}

output "vpc_this_id" {
  value = aws_vpc.this.id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.this.name
}