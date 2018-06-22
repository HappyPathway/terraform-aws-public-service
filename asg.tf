resource "aws_autoscaling_group" "scalegroup" {
  launch_configuration = "${aws_launch_configuration.service.name}"
  min_size             = "${var.min_size}"
  max_size             = "${var.max_size}"
  enabled_metrics      = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupTotalInstances"]
  metrics_granularity  = "1Minute"
  load_balancers       = ["${aws_elb.service.id}"]
  vpc_zone_identifier  = ["${var.private_subnet_id}"]
  health_check_type    = "ELB"
  default_cooldown     = "${var.default_cooldown}"

  name = "${var.service_name}-${var.service_version}-${var.env}"

  tag {
    key                 = "Name"
    value               = "${var.service_name}-${var.service_version}-${var.env}"
    propagate_at_launch = true
  }

  tag {
    key                 = "service_name"
    value               = "${var.service_name}"
    propagate_at_launch = true
  }

  tag {
    key                 = "service_version"
    value               = "${var.service_version}"
    propagate_at_launch = true
  }

  tag {
    key                 = "env"
    value               = "${var.env}"
    propagate_at_launch = true
  }
}
