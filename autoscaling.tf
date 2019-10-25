provider "aws" {
  region     = "${var.region}"
}

resource "aws_launch_configuration" "example" {
  image_id               = "${lookup(var.amis,var.region)}"
  instance_type          = "t2.micro"
  security_groups        = ["${aws_security_group.instance.id}"]
  key_name = "webservers"
  
  user_data = "${file("userdata.sh")}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "example" {
  launch_configuration = "${aws_launch_configuration.example.id}"
  availability_zones = data.aws_availability_zones.all.names
  min_size = 1
  max_size = 1
  load_balancers = ["${aws_elb.example.name}"]
  health_check_type = "ELB"
 
  tags = [
    {
      key                 = "Name"
      value               = "PlayQ-2019"
      propagate_at_launch = true
    },
    {
      key                 = "Type"
      value               = "webserver"
      propagate_at_launch = true
    },
  ]
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"
  
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${cidrhost("${var.myaddr}/${var.bits}", 0)}/${var.bits}"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${cidrhost("${var.PlayQaddr}/${var.bits}", 0)}/${var.bits}"]
  }
  
  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_availability_zones" "all" {}
