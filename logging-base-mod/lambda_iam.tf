#IAM role for splunk to access CW
resource "aws_iam_role" "splunk_readonly" {
  count = "${var.create_lambda}"
  name = "CloudwatchReadOnly-splunk"

  assume_role_policy = <<EOF
{
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Principal": {
            "Service": "lambda.amazonaws.com"
          },
          "Effect": "Allow",
          "Sid": ""
        }
      ]
}
EOF


  provisioner "local-exec" {
    command   = "sleep 20" # wait for instance profile to appear :(
  }
}

#Cloudwatch access IAM policy
data "aws_iam_policy_document" "cloudwatch_logs" { 

statement {
    sid = "1"

    actions = [
      "logs:CreateLogGroup",
      "logs:PutRetentionPolicy",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams",
      "logs:GetLogEvents",
      "cloudwatch:PutMetricAlarm",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:ListMetrics",
      "cloudwatch:DescribeAlarms"

    ]

    resources = [
      "arn:aws:logs:::*",
    ]
  }


}

#Cloudwatch policy
resource "aws_iam_policy" "cloudwatch_policy_splunk" {
  count = "${var.create_lambda}"
  name        = "EM-CloudwatchReadonly-splunk"
  description = "Cloudwatch Readonly Permissions"
  policy      = "${data.aws_iam_policy_document.cloudwatch_logs.json}"

  provisioner "local-exec" {
    command   = "sleep 20" # wait for instance profile to appear :(
  }
}

#Attach cloudwatch policy
resource "aws_iam_role_policy_attachment" "logpolicy-attach" {
  count = "${var.create_lambda}"
  role       = "${aws_iam_role.splunk_readonly.name}"
  policy_arn = "${aws_iam_policy.cloudwatch_policy_splunk.arn}"
}
