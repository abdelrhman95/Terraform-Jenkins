resource "aws_internet_gateway" "gw" {

 vpc_id = aws_vpc.iti-vpc.id

 

 tags = {

   Name = "Project-ITI igw"

 }

}