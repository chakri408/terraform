#Get VPC Id
data "aws_vpc" "svc_default" {
  filter {
    name   = "tag-value"
    values = ["default"]
  }
}

# Private subnet ids with the VPC
data "aws_subnet_ids" "private_subnet_ids" {
  vpc_id = "${data.aws_vpc.svc_default.id}"

  tags {
    Name = "Private*"
  }
}

#AWS ami id - It filters and fetch the most recent image with 
data "aws_ami" "appd_ami" {
  most_recent      = true
  owners           = ["89897257726"]

  tags {
    Name = "AppDynamics_Ext"
  }
}


data "aws_security_group" "infosec" {
filter {
    name   = "group-name"
    values = ["InfoSecScanner"]
  }

 filter {
    name   = "vpc-id"
    values = ["${data.aws_vpc.svc_default.id}"]
  }
}

 
