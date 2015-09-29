#! /bin/bash

DOCKER_TAG=$1
DOCKERRUN_FILE=$DOCKER_TAG-Dockerrun.aws.json
EB_BUCKET=$DEPLOYMENT_BUCKET/$BUCKET_DIRECTORY
# sample comment
echo "REGION=$REGION"
echo "AWS_APPLICATION_NAME=$AWS_APPLICATION_NAME"
echo "DOCEKR_TAG=$DOCKER_TAG"
echo "DOCKERRUN_FILE=$DOCKERRUN_FILE"
echo "DEPLOYMENT_BUCKET=$DEPLOYMENT_BUCKET"
echo "BUCKET_DIRECTORY=$BUCKET_DIRECTORY"

aws elasticbeanstalk create-application-version --region=$REGION --application-name $AWS_APPLICATION_NAME \
    --version-label $DOCKER_TAG --source-bundle S3Bucket=$DEPLOYMENT_BUCKET,S3Key=$BUCKET_DIRECTORY/$DOCKERRUN_FILE

# Update Elastic Beanstalk environment to new version (in case we want continuous delivery)
# aws elasticbeanstalk update-environment --region=us-east-1 --environment-name idsp-management-prod --version-label $SHA1
