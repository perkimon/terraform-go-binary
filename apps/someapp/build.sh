#!/bin/bash
export APP=someapp
export BUCKET=$AWS_BUILD_BUCKET
export BUILD=`date '+%Y%m%d_%H%M%S'`
export SALT=`uuidgen`
export DEST="s3://$BUCKET/builds/goserver/$SALT/$BUILD/$APP"
export S3PATH="/builds/goserver/$SALT/$BUILD/$APP"
echo "Building $APP to $DEST"
env GOOS=linux GOARCH=amd64 go build -o $APP
aws s3 cp $APP $DEST --acl public-read
rm -f $APP
echo "Version: http://$BUCKET.s3-website-eu-west-1.amazonaws.com$S3PATH"
