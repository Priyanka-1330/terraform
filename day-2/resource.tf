data "aws_vpc" "existing_vpc" {
    default = true
}

resource "aws_security_group" "sg" {
    name = "my_security_group"
    description = "my_security_group"
    vpc_id = data.aws_vpc.default.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_block = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol ="tcp"
        cidr_block =["0.0.0.0/0"]
    }
    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_block = ["0.0.0.0/0"]
    }
    tags {
        Name = "my_security_group"
    }
}


resource "aws_instance" "ec2" {
    ami = variable.ami
    instance_type = variable.instance_type
    key_name = variable.key_name
    vpc_security_group_ids = variable.sg_id
    user_data = file("/root/terraform/day-2/user_data.sh)
    root_block_device {
        volume_size = variable.volume_size
        volume_type = variable.volume_type
    }
    tags = variable.tags
}