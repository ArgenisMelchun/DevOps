#!/bin/bash

# Name of the S3 bucket
S3_BUCKET="stack-vwm-advanced-logistics-analytics-infrastructure"

# Get the directory where the script is located and move one level up
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Function to upload files and directories to S3
upload_to_s3() {
  local path=$1
  local s3_path=${path#"$PROJECT_ROOT/"}  # Get relative path, remove PROJECT_ROOT

  for item in "$path"/*; do
    if [ -d "$item" ]; then
      if [[ "$(basename "$item")" == "scripts" ]]; then
        echo "Skipping scripts directory: $item"
        continue
      fi
      # If it's a directory, upload recursively
      upload_to_s3 "$item"
    elif [ -f "$item" ] && [ "$(basename "$item")" != "README.md" ] && [ "$(basename "$item")" != "upload-to-s3.sh" ]; then
      if [[ "$path" == "$PROJECT_ROOT" ]]; then
        # If the file is in the root directory, upload directly to S3 root
        aws s3 cp "$item" "s3://$S3_BUCKET/$(basename "$item")"
      else
        # Otherwise, maintain folder structure in S3
        aws s3 cp "$item" "s3://$S3_BUCKET/${s3_path}/$(basename "$item")"
      fi
    fi
  done
}

# Upload all files and directories from the project root directory
upload_to_s3 "$PROJECT_ROOT"

echo "All files and folders have been uploaded to S3, maintaining structure except for root files."
