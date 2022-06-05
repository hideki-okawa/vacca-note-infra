resource "aws_eip" "nat_gateway" {
  for_each = local.nat_gateway_azs

  vpc = true

  tags = {
    Name = "${aws_vpc.this.tags.Name}-nat-gateway-${each.key}"
  }
}