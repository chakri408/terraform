output "asg_group" {
    value = "${aws_autoscaling_group.as-appd-ext.*.arn}"
}
