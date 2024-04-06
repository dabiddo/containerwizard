#!/bin/bash

# Function to print usage instructions
print_usage() {
    echo "Usage: ./vwiz.sh --laravel <project_name>"
    exit 1
}

# Check if the number of arguments is correct
if [ $# -ne 2 ]; then
    print_usage
fi

# Parse the arguments
while [ $# -gt 0 ]; do
    if [ "$1" = "--laravel" ]; then
        framework="laravel"
    else
        project_name="$1"
    fi
    shift
done

# If framework is not specified or is not supported, print usage instructions
if [ -z "$framework" ] || [ "$framework" != "laravel" ]; then
    print_usage
fi

# Check if the project name is provided
if [ -z "$project_name" ]; then
    echo "Project name not specified."
    print_usage
fi

# Create the project directory
mkdir "$project_name"
echo "Project directory '$project_name' created successfully."

# Create the .devcontainer folder inside the project directory
devcontainer_dir="$project_name/.devcontainer"
mkdir "$devcontainer_dir"
echo "Folder '.devcontainer' created inside '$project_name'."

# Create a default.json file inside the .devcontainer folder
touch "$devcontainer_dir/devcontainer.json"
echo "{\"key\": \"value\"}" > "$devcontainer_dir/devcontainer.json"
echo "devcontainer.json created successfully inside '$devcontainer_dir'."
