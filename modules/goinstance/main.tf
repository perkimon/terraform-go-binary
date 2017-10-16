variable "ec2_key" {}
variable "app" {}
variable "binary_src" {}
variable "platform" {}

data "template_file" "install" {
  template = "${file("${path.module}/install.sh")}"

  vars {
    app = "${var.app}"
    binary_src = "${var.binary_src}"
    platform = "${var.platform}"
  }
}

resource "aws_key_pair" "access-key" {
  key_name = "${var.app}-${var.platform}-access-key"
  public_key = "${var.ec2_key}"
}

resource "aws_security_group" "sg1" {
  name = "${var.app}-${var.platform}-sg"
  description = "Allow all inbound traffic"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 12345
    to_port = 12345
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "go-app" {
  //eu-west-1
  ami = "ami-af455dc9"

  //us-east-1
  //ami 	= "ami-a60c23b0"
  instance_type = "t2.nano"

  //key_name = "innovacore-v1"
  key_name = "${aws_key_pair.access-key.key_name}"

  user_data = "${data.template_file.install.rendered}"

  tags {
    Name = "${var.app}-${var.platform}"
  }

  vpc_security_group_ids = [
    "${aws_security_group.sg1.id}"]
}

output "ip" {
  value = "${aws_instance.go-app.public_ip}"
}

