resource "tls_private_key" "iti_rsa_tf" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "public_key-pair" {
    key_name = "bastion-key"
    public_key = tls_private_key.iti_rsa_tf.public_key_openssh

}


resource "local_file" "private-key-file" {
    filename = "tf.pem"
    content = tls_private_key.iti_rsa_tf.private_key_pem
    file_permission = "0400"
  
}