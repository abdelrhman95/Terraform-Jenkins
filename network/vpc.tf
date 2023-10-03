resource "aws_vpc" "iti-vpc" {
    cidr_block = var.cidr

    tags = {
        Name = "iti-vpc"
    }
  
}


