#!/bin/bash

# Script to deploy or update an AWS CloudFormation stack for creating an S3 bucket.
# This script prompts the user for the stack name and bucket name, then creates or updates the stack.
# The deployment includes server-side encryption and public access restrictions.

# Prompt for stack name
echo "Enter the CloudFormation stack name:"
read STACK_NAME

# Prompt for bucket name
echo "Enter the S3 bucket name (without prefix and environment):"
read BUCKET_NAME

# Define template file (hardcoded path)
TEMPLATE_FILE="../s3/s3.yaml"

# Check if the stack already exists
if aws cloudformation describe-stacks --stack-name "$STACK_NAME" >/dev/null 2>&1; then
    echo "Updating existing CloudFormation stack: $STACK_NAME"
    aws cloudformation update-stack \
        --stack-name "$STACK_NAME" \
        --template-body file://$TEMPLATE_FILE \
        --parameters ParameterKey=BucketName,ParameterValue="$BUCKET_NAME" \
        --capabilities CAPABILITY_NAMED_IAM \
    
    echo "Waiting for stack update to complete..."
    aws cloudformation wait stack-update-complete --stack-name "$STACK_NAME"
else
    echo "Creating new CloudFormation stack: $STACK_NAME"
    aws cloudformation create-stack \
        --stack-name "$STACK_NAME" \
        --template-body file://$TEMPLATE_FILE \
        --parameters ParameterKey=BucketName,ParameterValue="$BUCKET_NAME" \
        --capabilities CAPABILITY_NAMED_IAM \
    
    echo "Waiting for stack creation to complete..."
    aws cloudformation wait stack-create-complete --stack-name "$STACK_NAME"
fi

# Retrieve the output value from the stack
OUTPUT_KEY="S3BucketName"
OUTPUT_VALUE=$(aws cloudformation describe-stacks --stack-name "$STACK_NAME" \
    --query "Stacks[0].Outputs[?OutputKey=='$OUTPUT_KEY'].OutputValue" --output text)

# Check if the output value was retrieved successfully
if [ -n "$OUTPUT_VALUE" ]; then
    export BUCKET_NAME="$OUTPUT_VALUE"
    export S3_BUCKET="$OUTPUT_VALUE"
    echo "Environment variable BUCKET_NAME set to: $BUCKET_NAME"
else
    echo "Error: Could not retrieve the output value for key '$OUTPUT_KEY'."
fi

echo "CloudFormation stack $STACK_NAME successfully deployed or updated with bucket: $BUCKET_NAME"
