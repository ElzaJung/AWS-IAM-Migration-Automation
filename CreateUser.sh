# Automated user creation in the AWS

#!/bin/bash

INPUT=$1
OLDIFS=$IFS
IFS=',;'

[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }

command -v dos2unix >/dev/null || { echo "dos2unix tool not found. Please, install dos2unix tools before running the script."; exit 1; }

dos2unix $INPUT

while read -r user group password || [ -n "$user" ]
do
    if [ "$user" != "user" ]; then
	    aws iam create-user --user-name $user
        aws iam create-login-profile --password-reset-required --user-name $user --password $password
        aws iam add-user-to-group --group-name $group --user-name $user
	fi
    

done < $INPUT

IFS=$OLDIFS

# Make the script executable
# chmod +x ./CreateUser.sh

# Run the script
# ./CreateUser.sh AWS_Users.csv