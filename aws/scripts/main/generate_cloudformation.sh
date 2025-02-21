#!/bin/bash

# Prompt user for input values
read -p "Enter ResourcesPrefix: " RESOURCES_PREFIX
read -p "Enter Environment (dev, stage, prod): " ENVIRONMENT

# Define the input and output file names
TEMPLATE_FILE="main-template.yaml"
OUTPUT_FILE="../../main.yaml"  # Save the file two directories back

# Validate if the template file exists
if [ ! -f "$TEMPLATE_FILE" ]; then
    echo "❌ Error: The file $TEMPLATE_FILE was not found"
    exit 1
fi

# Ensure the target directory exists
mkdir -p "$(dirname "$OUTPUT_FILE")"

# Replace variables in the template and generate the final file
sed -e "s|{{ResourcesPrefix}}|$RESOURCES_PREFIX|g" \
    -e "s|{{Environment}}|$ENVIRONMENT|g" \
    "$TEMPLATE_FILE" > "$OUTPUT_FILE"

# Display success message
echo "✅ File generated: $(realpath "$OUTPUT_FILE")"
