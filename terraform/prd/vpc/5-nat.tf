resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "${var.env}-${local.application_name}-eip"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet1.id

  tags = {
    Name = "${var.env}-${local.application_name}-nat"
  }

  depends_on = [aws_internet_gateway.igw]
}
