#! /bin/bash

DOCKER_TAG=$1

echo "DOCKER_TAG = $DOCKER_TAG" 

DOCKERRUN_FILE=$DOCKER_TAG-Dockerrun.aws.json

echo "Creating $DOCKERRUN_FILE"

echo "Replacing tags:"
echo "DEPLOYMENT_BUCKET = $DEPLOYMENT_BUCKET"
echo "BUCKET_DIRECTORY = $BUCKET_DIRECTORY"
echo "IMAGE_NAME = $IMAGE_NAME"
echo "EXPOSED_PORTS = $EXPOSED_PORTS"
echo "AUTHENTICATION_KEY = $AUTHENTICATION_KEY"

# Replacing tags in the file and creating a file.
# prefix of file name is the tag.
sed -e "s/<TAG>/$DOCKER_TAG/" -e "s/<DEPLOYMENT_BUCKET>/$DEPLOYMENT_BUCKET/" -e "s/<IMAGE_NAME>/$IMAGE_NAME/" -e "s/<EXPOSED_PORTS>/$EXPOSED_PORTS/" -e "s/<AUTHENTICATION_KEY>/$AUTHENTICATION_KEY/" < Dockerrun.aws.json.template > $DOCKERRUN_FILE

echo "Done creating $DOCKERRUN_FILE"

S3_PATH="s3://$DEPLOYMENT_BUCKET/$BUCKET_DIRECTORY/$DOCKERRUN_FILE"
echo "Uploading json file to $S3_PATH"
aws s3 cp $DOCKERRUN_FILE $S3_PATH
