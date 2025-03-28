# Scripts Documentation

This folder contains various scripts used for managing and automating tasks related to AWS CloudFormation templates and infrastructure deployment. Below is a description of each script and its purpose.

## Scripts

### 1. `generate_cloudformation.sh`
- **Purpose**: 
  This script is used to generate a CloudFormation template (`main.yaml`) by replacing placeholders in a template file (`main-template.yaml`) with user-provided values.
  
- **How It Works**:
  - Prompts the user to input values for `ResourcesPrefix` and `Environment`.
  - Validates the existence of the input template file (`main-template.yaml`).
  - Replaces placeholders (`{{ResourcesPrefix}}` and `{{Environment}}`) in the template file with the provided values.
  - Outputs the final CloudFormation template (`main.yaml`) in the specified directory.

- **Usage**:
  ```bash
  chmod +x generate_cloudformation.sh
  ./generate_cloudformation.sh
  ```

### 2. `create-or-update-s3-bucket.sh`
- **Purpose**: 
  This script creates an S3 bucket if it does not already exist or updates its configuration if it does.

- **How It Works**:
  - Checks if the specified S3 bucket exists.
  - If the bucket does not exist, it creates the bucket with the specified configuration.
  - If the bucket exists, it updates the bucket's configuration (e.g., enabling versioning or encryption).

- **Usage**:
  ```bash
  chmod +x create-or-update-s3-bucket.sh
  ./create-or-update-s3-bucket.sh <bucket-name> <region>
  ```

### 3. `upload-to-s3.sh`
- **Purpose**: 
  This script uploads files or directories to a specified S3 bucket.

- **How It Works**:
  - Validates the existence of the specified S3 bucket.
  - Uploads the specified file or directory to the bucket.
  - Optionally sets metadata or permissions for the uploaded objects.

- **Usage**:
  ```bash
  chmod +x upload-to-s3.sh
  ./upload-to-s3.sh <bucket-name> <file-or-directory-path> <region>
  ```