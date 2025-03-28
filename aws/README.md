# AWS Infrastructure Deployment Guide

1. **Generate the `main.yaml` template**  
   Use the `/scripts/main/generate_cloudformation.sh` script to create the `main.yaml` template. Refer to the `scripts/README.md` for more details. During this process, you will be prompted to provide the prefix (e.g., `i24-081`) and the environment (`dev`, `staging`, `prod`).

2. **Create the S3 bucket for storing templates**  
   Use a meaningful name for the stack, such as: `i24-081-<environment>-vwm-logistics-analytics-infra-template-bucket-stack` and the bucket, such as: `vwm-logistics-analytics-infra-bucket`. (The prefix and environment will be automatically added by the CloudFormation template.)  
   To create the bucket with CF and persist environment variables using parameters, use the `/scripts/create-or-update-s3-bucket.sh` script. Make sure to source the script to export the variables. Refer to `scripts/README.md` for additional guidance.

3. **Upload CloudFormation templates to the S3 bucket**  
   Use the `/scripts/upload-to-s3.sh` script to upload the CloudFormation templates to the S3 bucket. Ensure that the `BUCKET_NAME` environment variable is set before running the script.

4. **Create the parameters stack**  
   Manually create a stack to define all the parameters required for the infrastructure. Use a meaningful name, such as `i24-081-<environment>-vwm-advanced-logistics-analytics-infra-parameters`.  
   This stack is used to set all the parameters that will later be referenced in the root stack (`main.yaml`) to create the infrastructure.

5. **Deploy the root stack**  
   Once the parameters stack is created, deploy the root stack (`main.yaml`) using the AWS Management Console, AWS CLI. Ensure that the `TEMPLATE_URL` points to the `main.yaml` file stored in the S3 bucket give an name such as: "i24-081-<environment>-vwm-logistics-analytics-infra-stack"