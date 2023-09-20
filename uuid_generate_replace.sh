#!/bin/bash

# Define the path to your YAML file
file_path="temp copy 3.yml"
# Function to generate a new 32-character UUID
generate_new_uuid() {
  new_uuid=$(uuidgen -r | tr -d '-')
  echo "$new_uuid"
}
# Loop through each line in the file
while IFS= read -r line; do
  # Check if the line contains "uuid: ..."
  if [[ $line == *"- uuid: "* ]]; then
    # Replace the line with a new 32-character UUID
    new_uuid=$(generate_new_uuid)
    echo "uuid: $new_uuid"
  else
    # Keep the line as is
    echo "$line"
  fi
done < "$file_path" > temp.yml.tmp

# Replace the original file with the temporary file
mv temp.yml.tmp "$file_path"

echo "Done"
