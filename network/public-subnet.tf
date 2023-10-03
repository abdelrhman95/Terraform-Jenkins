resource "aws_subnet" "first-Public" {
  vpc_id     = aws_vpc.iti-vpc.id
  cidr_block = var.public_1_CIDR
  availability_zone = "us-east-1a"

  tags = {
    Name = "first_public_sn"
  }
}




resource "aws_subnet" "seconed-Public" {
  vpc_id     = aws_vpc.iti-vpc.id
  cidr_block = var.public_2_CIDR
  availability_zone = "us-east-1b"

  tags = {
    Name = "sec_public_sn"
  }
}