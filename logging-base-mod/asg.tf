# Template for initial configuration bash script
# User script set the right cluster name (cloud account name) in Appd configuration files
data "template_file" "user-data-asg" {
  template = "${file("${path.module}/user_data_asg.tpl")}"

  vars {
    account_name          = "${var.aws_account_name}"
  }
}

#Setting launch configuration with user data
resource "aws_launch_configuration" "lc-appd-ext" {
  count = "${var.create_ec2}"
  name_prefix   = "sre-appd-ext"
  image_id      = "${data.aws_ami.appd_ami.image_id}"
  instance_type = "t2.large"
  iam_instance_profile = "${aws_iam_instance_profile.app-server.name}"
  security_groups = ["${aws_security_group.app-sg.id}", "${data.aws_security_group.infosec.id}"]
  #key_name               = "${var.instance_key}"
  user_data = "${data.template_file.user-data-asg.rendered}"

  lifecycle {
    create_before_destroy = true
  }
}

#ASG with min and max 1 node.
resource "aws_autoscaling_group" "as-appd-ext" {
  count = "${var.create_ec2}"
  name                 = "sre-appd-ext"
  launch_configuration = "${aws_launch_configuration.lc-appd-ext.name}"
  min_size             = 1
  max_size             = 1
  desired_capacity =  1
  vpc_zone_identifier = ["${data.aws_subnet_ids.private_subnet_ids.ids}"]
  tags = ["${concat(list(
    map("key", "Name", "value", "${var.stack}-${var.application_id}", "propagate_at_launch", true),
    map("key", "ApplicationId", "value", "${var.application_id}", "propagate_at_launch", true)
    ), var.asg_tags)}"]

  lifecycle {
    create_before_destroy = true
  }
}
