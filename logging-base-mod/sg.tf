# Our default security group to access
# the instances over SSH and HTTP
resource "aws_security_group" "app-sg" {
  count = "${var.create_ec2}"
  name        = "${var.stack}-${var.application_id}"
  description = "${var.stack}-${var.application_id}"
  vpc_id      = "${data.aws_vpc.svc_default.id}"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

#  # HTTP access from the VPC
#  ingress {
#    from_port   = 80
#    to_port     = 80
#    protocol    = "tcp"
#    cidr_blocks = ["10.0.0.0/8"]
#  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
