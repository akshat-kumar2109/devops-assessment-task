resource "aws_internet_gateway" "main" {
  vpc_id = var.vpc_id

  tags = merge(
    {
      Name = var.gateway_name
    },
    var.tags
  )
}

resource "aws_eip" "nat" {
  count = var.create_nat_gateway ? 1 : 0
  domain = "vpc"

  tags = merge(
    {
      Name = "${var.gateway_name}-nat-eip"
    },
    var.tags
  )

  depends_on = [aws_internet_gateway.main]
}

resource "aws_nat_gateway" "example" {
  count = var.create_nat_gateway ? 1 : 0

  allocation_id = aws_eip.nat[0].id
  subnet_id     = var.public_subnet_id

  tags = merge(
    {
      Name = "${var.gateway_name}-nat"
    },
    var.tags
  )

  depends_on = [aws_internet_gateway.main]
}