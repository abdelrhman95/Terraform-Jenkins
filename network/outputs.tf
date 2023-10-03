#


output "vpc_id" {
    value = aws_vpc.iti-vpc.id
  
}

output "public_sub1_id" {
    value = aws_subnet.first-Public.id
  
}

output "public_sub2_id" {
    value = aws_subnet.seconed-Public.id 
  
}

output "private_sub1_id" {
    value = aws_subnet.first-Private.id
  
}


output "private_sub2_id" {
    value = aws_subnet.seconed-Private.id
  
}

output "ssh_sg_id" {
    value = aws_security_group.public-sec.id

  
}

output "ssh_sg_p3000_id" {
    value = aws_security_group.private-sec.id
  
}