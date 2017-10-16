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
	binary_src = "http://artifacts.innoacore.co.uk.s3-website-eu-west-1.amazonaws.com/builds/goserver/CE201315-424D-4ABF-8E0B-4BFFCF401FD1/20171016_170348/someapp"
}

output "app1-ip" {
  value = "${module.app1.ip}"
}

