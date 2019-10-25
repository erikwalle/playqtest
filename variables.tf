variable "servercount" {
    default = 1
}

variable "region" {
  default = "us-east-1"
}

variable "amis" {
  default = {
    us-east-1 = "ami-092546daafcc8bc0d"
    us-east-2 = "ami-be7753db"
    us-west-1 = "ami-0bc498f1207abb85c"
    us-west-2 = "ami-017e1dd35b94fb074"
  }
}

resource "aws_key_pair" "webservers" {
  key_name   = "webservers"
  public_key = "${file("me.pub")}"
}

variable "myaddr" { default = "104.32.73.65" }
variable "PlayQaddr" { default = "76.169.181.157" }
variable "bits" { default = "32" }
