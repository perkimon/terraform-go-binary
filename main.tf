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
	app = "goapp2"
	platform = "test"
	binary_src = "http://artifacts.innovacore.co.uk.s3-website-eu-west-1.amazonaws.com/builds/goserver/20171013_122203/app"
	domain = "sliderdown.co.uk"
}

output "app1-ip" {
  value = "${module.app1.ip}"
}

output "app1-dns" {
  value = "${module.app1.dns}"
}
