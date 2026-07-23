resource "aws_vpc" "my-vpc" {
    cidr_block = var.cidr_block_vpc
    tags = {
        Name = "my-vpc"
    }
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = var.cidr_subnet_pub
    availability_zone = var.az_pub
    tags = {
      Name = "public_subnet"
    }
    map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = var.cidr_subnet_pvt
    availability_zone = var.az_pvt
    tags = {
      Name = "private_subnet"
    }
}

resource "aws_internet_gateway" "IGW" {
    vpc_id = aws_vpc.my-vpc.id
    tags = {
      Name = "IGW"
    }
}

resource "aws_eip" "nat_eip" {
    domain = "vpc"
    tags = {
      Name = "nat-eip"
    }
}

resource "aws_nat_gateway" "nat_gateway" {
    subnet_id = aws_subnet.public_subnet.id
    allocation_id = aws_eip.nat_eip.id
    tags = {
      Name = "nat-Gateway"
    }
}

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.my-vpc.id
    route = {
        gateway_id = aws_internet_gateway.IGW.id
        cidr_block = "0.0.0.0/0"
    }
}

resource "aws_route_table_association" "public_rt_assoc" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.my-vpc.id
    route = {
        cidr_block ="0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gateway.id
    }
}

resource "aws_route_table_association" "private_rt_assoc" {
    subnet_id = aws_subnet.private_subnet.id
    route_table_id = aws_route_table.private_rt.id
  
}

resource "aws_security_group" "my-vpc-sg-tf" {
    name = "my-security-group-"
    description = "my-security-group-"
    vpc_id =  aws_vpc.my-vpc.id 

    ingress {
        from_port = var.ssh_port
        to_port = var.ssh_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = var.http_port
        to_port = var.http_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
      Name = "my-security-group-vpc-tf"
    }
}

resource "aws_instance" "public_instance" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.my-vpc-sg-tf.id]
    subnet_id = aws_subnet.public_subnet.id
    associate_public_ip_address = true
    user_data = file("/root/terraform/day-3-vpc/user-data.sh")
    tags = {
      Name = "public-instance"
    }
}

resource "aws_instance" "private_instance" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.my-vpc-sg-tf.id]
    subnet_id = aws_subnet.private_subnet
    user_data = file("/root/terraform/day-3-vpc/user-data.sh")
    tags = {
      Name = "private-instance"
    }
}
