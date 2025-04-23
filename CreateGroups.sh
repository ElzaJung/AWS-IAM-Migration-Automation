#!/bin/bash

group_names=("CloudAdmin" "DBA" "LinuxAdmin" "NetworkAdmin")
group_policies=(
  "arn:aws:iam::aws:policy/AdministratorAccess"
  "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
  "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
)

for i in "${!group_names[@]}"; do
  group="${group_names[$i]}"
  policy="${group_policies[$i]}"
  echo "Creating group: $group"
  aws iam create-group --group-name "$group"
  echo "Attaching policy to group: $group"
  aws iam attach-group-policy --group-name "$group" --policy-arn "$policy"
  if [ $? -eq 0 ]; then
    echo "Successfully attached policy to $group"
  else
    echo "Failed to attach policy to $group"
  fi
done

echo "Script execution completed."


# Make executable
# chmod +x # ./CreateGroups.sh

# Run the script
# bash ./CreateGroups.sh