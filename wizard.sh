#!/bin/bash

# Get the current directory
current_path=$(pwd)

# Print the current directory
echo "Current directory: $current_path"

# Extract the last component of the current directory path (the directory name)
current_dir=$(basename "$current_path")

# Print the directory name
echo "Current directory name: $current_dir"

# Extract the last part of the current directory (the folder name)
folder_name=".devcontainer"

# Check if the folder already exists
if [ -d "$folder_name" ]; then
    echo "Folder '$folder_name' already exists in the current directory."
else
    # Create the folder
    mkdir "$folder_name"
    echo "Folder '$folder_name' created successfully."

    # Create a default.json file inside the folder
    touch "$folder_name/devcontainer.json"
    echo "{\"key\": \"value\"}" > "$folder_name/devcontainer.json"
    echo "devcontainer.json created successfully."
fi
