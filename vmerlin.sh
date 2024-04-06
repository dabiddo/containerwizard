#!/bin/bash

# Function to create a new project
create_project() {
    read -p "Enter project name: " project_name
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
}

# Function to install container
install_container() {
    # Create the .devcontainer folder
    devcontainer_dir=".devcontainer"
    mkdir "$devcontainer_dir"
    echo "Folder '.devcontainer' created."

    # Create a default.json file inside the .devcontainer folder
    touch "$devcontainer_dir/devcontainer.json"
    echo "{\"key\": \"value\"}" > "$devcontainer_dir/devcontainer.json"
    echo "devcontainer.json created successfully inside '$devcontainer_dir'."
}

# Interactive menu
PS3="Select an option: "
options=("Create a new project" "Install container" "Quit")

select opt in "${options[@]}"; do
    case $REPLY in
        1) create_project ;;
        2) install_container ;;
        3) echo "Exiting..."; exit ;;
        *) echo "Invalid option. Please select again." ;;
    esac
done
