variable "aws_access_key" {}
variable "aws_secret_key" {}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "eu-west-1"
}

module "app1" {
	source = "./modules/goinstance"
  	ec2_key = "${file("~/.ssh/id_rsa.pub")}"
	app = "app1"
	platform = "test"
	binary_src = "http://output-from-build-step"
}

output "app1-ip" {
  value = "${module.app1.ip}"
}

