variable "ami" {
    default = "ami-0b1ed96948adabcd9"
}
variable "instance_type" {
    default = "t3.micrp"
}

variable "key_name" {
    default = "AWS-New-key"
}

variable "sg_id" {
    default = "sg-0d3029db57768f59f"
}

variable "volume_size" {
    default = 8
}
variable "volume_type" {
    default = "gp3"
}
variable "tags" {
    type = map(string)
    default = {
        Name ="webserver"
    }
}