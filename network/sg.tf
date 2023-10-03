resource "aws_security_group" "public-sec" {
  name        = "allow_outbound"
  description = "allow_out-traffic"
  vpc_id      = aws_vpc.iti-vpc.id

  ingress {
    description      = "ssh from outside"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    # Terraform removes the default rule 
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "public-sec"
  }
}

resource "aws_security_group" "private-sec" {
  name        = "allow_inbound"
  description = "allow_inbound-traffic"
  vpc_id      = aws_vpc.iti-vpc.id

  ingress {
    description      = "ssh from inside"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.iti-vpc.cidr_block]
  }


  ingress {
    description      = "from vpc"
    from_port        = 3000
    to_port          = 3000
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.iti-vpc.cidr_block]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "private-sec"
  }
}