aws s3 rm --recursive s3://$AWS_BUILD_BUCKET
terraform destroy --force
