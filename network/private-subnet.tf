resource "aws_subnet" "first-Private" {
  vpc_id     = aws_vpc.iti-vpc.id
  cidr_block =var.private_1_CIDR
  availability_zone = "us-east-1a"

  tags = {
    Name = "first_private_sn"
  }
}




resource "aws_subnet" "seconed-Private" {
  vpc_id     = aws_vpc.iti-vpc.id
  cidr_block = var.private_2_CIDR
  availability_zone = "us-east-1b"

  tags = {
    Name = "sec_private_sn"
  }
}