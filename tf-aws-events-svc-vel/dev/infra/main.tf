module "svc-dev" {
		source = "git::http://github.com/chakri408/svc-logging-base-mod.git?ref=develop"
		instance_type = "t2.large"
                environment = "dev"                                     #Env variable, prod or dev
                stack = "dev1"                                          #Stack dev1 or prod1. Increment if we spin nodes, usually it ends with 1 as we spin one node per aws account
		aws_account_name = "svc-dev" 			#AWS account name as a identifier
		region = "us-east-1"  					# Use us-east-1 for east region
		avail_zones = ["us-east-1a", "us-east-1b"] 		#Use ["us-east-1a", "us-east-1b"]
		splunk_source_type = "Test"
		create_ec2 = "1" 					#Option to create ec2 resource, 0 to false, 1 to true
		create_lambda = "1" 					#Option to create lambda resource, 0 to false, 1 to true
}
