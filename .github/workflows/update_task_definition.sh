#!/bin/bash

# Extract the GitHub SHA and environment from the environment variable
GITHUB_SHA=${GITHUB_SHA:0:7}  
# ENVIRONMENT=${ENVIRONMENT}

# Update the image version in the task-definition.json file
sed -i 's/349498089405.dkr.ecr.ap-southeast-2.amazonaws.com\/crankbit-backend-main:latest/349498089405.dkr.ecr.ap-southeast-2.amazonaws.com\/crankbit-backend-main:'"$GITHUB_SHA"'/g' .github/workflows/task_definition_main.json
