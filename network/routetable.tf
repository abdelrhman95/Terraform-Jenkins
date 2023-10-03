resource "aws_route_table" "public_rtb" {

 vpc_id = aws_vpc.iti-vpc.id
 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.gw.id
 }

 tags = {

   Name = "public_rtb"

 }

}

resource "aws_route_table" "private-rtb" {
  vpc_id = aws_vpc.iti-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

   tags = {
    Name = "private_table"
  }

}





resource "aws_route_table_association" "association-fpublic" {
  subnet_id      = aws_subnet.first-Public.id
  route_table_id = aws_route_table.public_rtb.id
}

resource "aws_route_table_association" "association-Spublic" {
  subnet_id      = aws_subnet.seconed-Public.id
  route_table_id = aws_route_table.public_rtb.id
}


resource "aws_route_table_association" "private-1" {
  subnet_id      = aws_subnet.first-Private.id
  route_table_id = aws_route_table.private-rtb.id
}

resource "aws_route_table_association" "private-2" {
  subnet_id      = aws_subnet.seconed-Private.id
  route_table_id = aws_route_table.private-rtb.id 
}