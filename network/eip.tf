resource "aws_eip" "lb" {

  tags = {
    "Name" = "eip-nat"
  }
}


