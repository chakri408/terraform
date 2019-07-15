provider "aws" {
    region = "${var.region}"
}

#Lambda function to push events to splunk

resource "aws_lambda_function" "svc-splunk" {
    count = "${var.create_lambda}"
    function_name = "${var.lambda_name}"
    description = "Cloudwatch logs to Splunk in data center through HEC"
    handler = "index.handler"
    runtime = "${var.lambda_runtime}"
    timeout = "${var.lambda_timeout}"
   # filename = "${var.splunk_function_file}"
    filename = "${path.module}/svclogs-splunk.zip"
    source_code_hash = "${base64sha256(file("${path.module}/svclogs-splunk.zip"))}"
    role = "${aws_iam_role.splunk_readonly.arn}"

  environment {
    variables = {
      SPLUNK_HEC_TOKEN = "${var.splunk_token}"
      SPLUNK_HEC_URL   = "${var.splunk_url}" 
      SPLUNK_SOURCE_TYPE = "${var.splunk_source_type}"
    }
  }
}



