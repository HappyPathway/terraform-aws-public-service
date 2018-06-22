resource "aws_security_group" "service" {
  name   = "${var.service_name}-${var.service_version}-${var.env}-nodes"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port       = "${var.service_port}"
    to_port         = "${var.service_port}"
    protocol        = "tcp"
    security_groups = ["${aws_security_group.elb.id}"]
  }

  # ALLOW ALL EAST/WEST TRAFFIC BETWEEN NODES
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = -1
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "elb" {
  vpc_id = "${var.vpc_id}"
  name   = "${var.service_name}-${var.service_version}-${var.env}-elb"

  ingress {
    from_port   = "${var.service_port}"
    to_port     = "${var.service_port}"
    protocol    = "tcp"
    cidr_blocks = ["${var.service_access}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}
