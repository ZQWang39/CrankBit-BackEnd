#!/bin/bash

# Extract the GitHub SHA and environment from the environment variable
GITHUB_SHA=${GITHUB_SHA:0:7}  
ENVIRONMENT=${TARGET_ENV}

# Update the image version in the task-definition.json file
sed -i 's~349498089405.dkr.ecr.ap-southeast-2.amazonaws.com/crankbit-backend-'"$ENVIRONMENT"':latest~349498089405.dkr.ecr.ap-southeast-2.amazonaws.com/crankbit-backend-'"$ENVIRONMENT"':'"$GITHUB_SHA"'~g' .github/workflows/task_definition.json

# Update the family and executionRoleArn values in the task-definition.json file
sed -i 's/crankbit_backend_task_.*\([^"]*\)/crankbit_backend_task_'"$ENVIRONMENT"'\1/' .github/workflows/task_definition.json
sed -i 's/ecs-task-execution-role-.*\([^"]*\)/ecs-task-execution-role-'"$ENVIRONMENT"'\1/' .github/workflows/task_definition.json

# Update the container name in the task-definition.json file (containerDefinitions block)
sed -i 's/"name": "crankbit-backend-.*"/"name": "crankbit-backend-'"$ENVIRONMENT"'"/' .github/workflows/task_definition.json