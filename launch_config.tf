data "aws_security_group" "admin" {
  name = "${var.private_subnet_id}-subnet-admin"
}

resource "aws_launch_configuration" "service" {
  image_id        = "${data.aws_ami.service_ami.image_id}"
  instance_type   = "${var.instance_type}"
  security_groups = ["${aws_security_group.service.id}", "${data.aws_security_group.admin.id}"]
  key_name        = "${var.key_name}"
  name_prefix     = "${var.service_name}-${var.service_version}-${var.env}"

  lifecycle {
    create_before_destroy = true
  }
}
