# Add IAMUserChangePassword policy to groups

#!/bin/bash

# Replace with your AWS account ID
ACCOUNT_ID="ACCOUNT_ID"

# List of group names
GROUP_NAMES=("CloudAdmin" "DBA" "LinuxAdmin" "NetworkAdmin")

# IAM policy ARN for the IAMUserChangePassword policy
POLICY_ARN_CHANGE_PASSWORD="arn:aws:iam::aws:policy/IAMUserChangePassword"

# Function to check if a group exists
group_exists() {
  aws iam get-group --group-name "$1" > /dev/null 2>&1
  return $?
}

# Loop through each group and attach the policy
for GROUP_NAME in "${GROUP_NAMES[@]}"; do
  echo "Checking if group exists: $GROUP_NAME"
  if group_exists "$GROUP_NAME"; then
    echo "Attaching policy to group: $GROUP_NAME"
    aws iam attach-group-policy --group-name "$GROUP_NAME" --policy-arn "$POLICY_ARN_CHANGE_PASSWORD"
    if [ $? -eq 0 ]; then
      echo "Successfully attached policy to $GROUP_NAME"
    else
      echo "Failed to attach policy to $GROUP_NAME"
    fi
  else
    echo "Group $GROUP_NAME does not exist"
  fi
done

# chmod +x ./UserPasswordChange.sh
# ./UserPasswordChange.sh