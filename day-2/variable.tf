variable "ami" {
  default = "ami-0b1ed96948adabcd9"
}

variable "key_name" {
  default = "AWS-New-key"
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
    Name = "webserver"
  }
}