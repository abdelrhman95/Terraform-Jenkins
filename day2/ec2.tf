 resource "aws_instance" "bastion_vm" {
  ami = var.ami_id              #"ami-053b0d53c279acc90"
  instance_type = "t2.micro"
  subnet_id = module.network.public_sub1_id

  vpc_security_group_ids = [module.network.ssh_sg_id]
  associate_public_ip_address = true
  key_name = aws_key_pair.public_key-pair.key_name



  provisioner "local-exec" {
    command = "echo ${self.public_ip} is the public IP of the Bastion Instance > inventory.txt" 
  }
  
  
  user_data = <<-EOF
              #!/bin/bash
              echo '${tls_private_key.iti_rsa_tf.private_key_openssh}' > /home/ubuntu/tf.pem
              chmod 0400 /home/ubuntu/tf.pem
              EOF

  tags = {
    Name = "BastionVm"
  }


} 


resource "aws_instance" "Application" {

    ami = var.ami_id
    instance_type = "t2.micro"
    subnet_id = module.network.private_sub1_id
    vpc_security_group_ids = [module.network.ssh_sg_p3000_id]
    key_name = aws_key_pair.public_key-pair.key_name
    tags = {
      Name = "Application"
    }
  
}
