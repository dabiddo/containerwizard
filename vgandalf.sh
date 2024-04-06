#!/bin/bash

# Function to create a new Laravel project using Docker
create_laravel_project() {
    read -p "Enter project name: " project_name
    docker run --rm -v "$(pwd)":/app composer create-project --prefer-dist laravel/laravel "$project_name"
    sudo chown -R "$USER":"$USER" "$project_name"
    echo "Ownership changed to $USER:$USER for '$project_name'."
}

# Interactive menu
PS3="Select an option: "
options=("Create a new Laravel project" "Quit")

select opt in "${options[@]}"; do
    case $REPLY in
        1) create_laravel_project ;;
        2) echo "Exiting..."; exit ;;
        *) echo "Invalid option. Please select again." ;;
    esac
done
