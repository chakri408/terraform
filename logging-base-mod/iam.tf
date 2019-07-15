# Application role & default trust policy
data "aws_iam_policy_document" "default-trust-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

#Create new IAM server role

resource "aws_iam_role" "app-server" {
  count = "${var.create_ec2}"
  name               = "${var.stack}-${var.application_id}-server"
  assume_role_policy = "${data.aws_iam_policy_document.default-trust-policy.json}"
}


resource "aws_iam_instance_profile" "app-server" {
  count = "${var.create_ec2}"
  name = "${aws_iam_role.app-server.name}"
  role = "${aws_iam_role.app-server.name}"

  provisioner "local-exec" {
    command = "sleep 30" # wait for instance profile to appear :(
  }
}

#cloudwatch_iam_policy IAM policy
data "aws_iam_policy_document" "cloudwatch_access" {
  statement {
    effect = "Allow"

    actions = [
      "cloudwatch:DescribeAlarmHistory",
      "cloudwatch:GetDashboard",
      "ec2:DescribeInstances",
      "cloudwatch:GetMetricData",
      "cloudwatch:DescribeAlarmsForMetric",
      "ec2:DescribeTags",
      "cloudwatch:ListTagsForResource",
      "cloudwatch:DescribeAlarms",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:GetMetricWidgetImage",
      "cloudwatch:ListMetrics",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams",
    ]

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "cloudwatch_policy" {
  count = "${var.create_ec2}"
  name        = "${var.stack}-${var.application_id}-cloudwatch-metrics"
  description = "Cloudwatch access for ${var.stack} ${var.application_id}"
  policy      = "${data.aws_iam_policy_document.cloudwatch_access.json}"

  provisioner "local-exec" {
    command = "sleep 30" # wait for instance profile to appear :(
  }
}

resource "aws_iam_policy_attachment" "cloudwatch_access" {
  count = "${var.create_ec2}"
  name       = "${var.stack}-${var.application_id}-attachment"
  roles      = ["${aws_iam_role.app-server.name}"]
  policy_arn = "${aws_iam_policy.cloudwatch_policy.arn}"
}
