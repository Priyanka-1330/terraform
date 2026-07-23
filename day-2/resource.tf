resource "aws_instance" "ec2" {
    ami           = var.ami
    instance_type = var.instance_type
    key_name      = var.key_name 
    disable_api_termination = false 
    vpc_security_group_ids = ["sg-0d3029db57768f59f"]
    user_data = file("/root/terraform/day-2/user_data.sh")

    root_block_device {
        volume_size = var.volume_size
        volume_type = var.volume_type
    }

    tags = var.tags

}