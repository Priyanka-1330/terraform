varialble "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    default = "10.0.0.0/24"
}

variable "public_az" {
    default = "ap-south-1a"
}

variable "private_subnet_cidr" {
    default = "10.0.1.0/24"
}

varialble "ami" {
    default = "ami-0b1ed96948adabcd9"
}

variable "instance_type" {
    default = "t3.micro"
}

variable "key_name" {
    default = "AWS-New-key"
}