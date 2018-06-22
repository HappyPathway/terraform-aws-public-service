resource "aws_elb" "service" {
  name            = "${var.service_name}-${join("-", split(".", var.service_version))}-${var.env}"
  subnets         = ["${var.public_subnet_id}"]
  security_groups = ["${aws_security_group.elb.id}"]
  internal        = false

  #access_logs {
  #	bucket = "${aws_s3_bucket.bucket.tags.Name}"
  #	interval = 5
  #}

  listener {
    instance_port     = "${var.service_port}"
    instance_protocol = "${var.instance_protocol}"
    lb_port           = "${var.service_port}"

    # lb_protocol = "${var.lb_protocol}"
    lb_protocol = "http"

    # ssl_certificate_id = "${data.aws_acm_certificate.service.arn}"
  }

  health_check {
    healthy_threshold   = "${var.service_healthcheck_healthy_threshold}"
    unhealthy_threshold = "${var.service_healthcheck_unhealthy_threshold}"
    timeout             = "${var.service_healthcheck_timeout}"
    target              = "TCP:${var.service_port}"
    interval            = "${var.service_healthcheck_interval}"
  }
  
  cross_zone_load_balancing   = "${var.cross_zone_load_balancing}"
  idle_timeout                = "${var.idle_timeout}"
  connection_draining         = "${var.connection_draining}"
  connection_draining_timeout = "${var.connection_draining_timeout}"
  tags {
    Name = "${var.service_name}-${var.service_version}-${var.env}"
  }
}

resource "aws_lb_cookie_stickiness_policy" "cookie_stickiness" {
  name                     = "${var.service_name}-${join("-", split(".", var.service_version))}-${var.env}-cookiestickness"
  load_balancer            = "${aws_elb.service.id}"
  lb_port                  = "${var.service_port}"
  cookie_expiration_period = 600
}
