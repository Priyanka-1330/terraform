variable "cidr_block_vpc" {
    default = "10.0.0.0/16"
}

variable "cidr_subnet_pub" {
    default = "10.0.0.0/24" 
}

variable "az_pub" {
    default = "ap-south-1a"  
}

variable "cidr_subnet_pvt" {
    default = "10.0.1.0/24"
}

variable "az_pvt" {
    default = "ap-south-1b"
}

variable "ssh_port" {
    default = 22
}

variable "http_port" {
    default = 80 
}

variable "ami" {
    default = "ami-0b1ed96948adabcd9"
}

variable "instance_type" {
    default ="t3.micro"
}

variable "key_name" {
    default = "AWS-New-key"
}