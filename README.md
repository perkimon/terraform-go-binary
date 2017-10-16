## Purpose

Having recently learned terraform I wanted to demo a way to create a simple golang application and run it in the cloud with the minimum amount of code


## How it works

A binary application is compiled and uploaded to an S3 bucket.
An EC2 node is launched with instructions on how to pull down the binary and run it.
That's it.


## Instructions

1. export AWS Access and Secret keys if necessary
	`export TF_VAR_aws_access_key=your-access-key`
	`export TF_VAR_aws_secret_key=your-secret-key`
2. Create Artifacts bucket
	`cd artifacts`
	`vim config.auto.tfvars` choose a unique bucket
	`./apply.sh`
	Make sure you export AWS_BUILD_BUCKET with the output of the build
3. Build your app
	`cd app/someapp`
	`./build.sh`

4. Set main.tf:binary_src with the output of the previous step

5. Run `terraform plan` followed by `terraform apply`

6. wait for the output IP address and visit http://IP:12345/will
