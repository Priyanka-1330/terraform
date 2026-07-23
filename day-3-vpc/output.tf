output "public_ip" {
    value = aws_instance.public_instance.public_ip
}

output "my-security-group-vpc-tf" {
    value = aws_security_group.my-vpc-sg-tf.id 
}

output "instance_id" {
    value = aws_instance.public_instance.id 
}

output "public_subnet_id" {
    value = aws_subnet.public_subnet.id 
}
