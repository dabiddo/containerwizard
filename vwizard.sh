#!/bin/bash

# Function to create a new Laravel project using Docker
create_laravel_project() {
    read -p "Enter project name: " project_name
    docker run --rm -v "$(pwd)":/app composer create-project --prefer-dist laravel/laravel "$project_name"
    sudo chown -R "$USER":"$USER" "$project_name"
    echo "Ownership changed to $USER:$USER for '$project_name'."
}


# Main Menu
gum style --border normal --margin "1" --padding "1 2" --border-foreground 12 "Hello, there! Welcome to $(gum style --foreground 12 'DockerWizard')."

echo "What do you want to do?"
CHOICE=$(gum choose --item.foreground 250 "Create a new Laravel project" "Quit")

if [[ "$CHOICE" == "Create a new Laravel project" ]]; then
    sleep 1; clear
    create_laravel_project 
elif [[ "$CHOICE" == "Quit" ]]; then
    echo "Exiting..."; exit
fi
