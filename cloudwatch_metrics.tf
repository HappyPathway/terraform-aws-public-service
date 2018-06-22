resource "aws_cloudwatch_metric_alarm" "cpualarm" {
  alarm_name          = "${var.service_name}-${var.service_version}-${var.env}-cpu_up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "${var.cloudwatch_evaluation_periods}"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "${var.cloudwatch_metric_interval}"
  statistic           = "Average"
  threshold           = "${var.high_cpu}"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.scalegroup.name}"
  }

  alarm_description = "This metric monitor EC2 instance cpu utilization"
  alarm_actions     = ["${aws_autoscaling_policy.autopolicy.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "cpualarm-down" {
  alarm_name          = "${var.service_name}-${var.service_version}-${var.env}-cpu_down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "${var.cloudwatch_evaluation_periods}"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "${var.cloudwatch_metric_interval}"
  statistic           = "Average"
  threshold           = "${var.low_cpu}"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.scalegroup.name}"
  }

  alarm_description = "This metric monitor EC2 instance cpu utilization"
  alarm_actions     = ["${aws_autoscaling_policy.autopolicy-down.arn}"]
}
