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
  }
}

resource "aws_key_pair" "webservers" {
  key_name   = "webservers"
  public_key = "${file("me.pub")}"
}

variable "myaddr" { default = "104.32.73.65" }
variable "PlayQaddr" { default = "76.169.181.157" }
variable "bits" { default = "32" }
