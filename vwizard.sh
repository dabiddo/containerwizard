#!/bin/bash

# Function to create a new Laravel project using Docker
create_laravel_project() {
    read -p "Enter project name: " project_name
    docker run --rm -v "$(pwd)":/app composer create-project --prefer-dist laravel/laravel "$project_name"
    sudo chown -R "$USER":"$USER" "$project_name"
    echo "Ownership changed to $USER:$USER for '$project_name'."
}

# Function to create a new NuxtJs project using Docker
create_nuxt_project() {
    read -p "Enter project name: " project_name
    docker run --rm -v "$(pwd):/app" -w /app -it node:20.11.1-alpine sh -c "apk add --no-cache git && npm install -g pnpm && pnpm dlx nuxt@latest init $project_name && chown -R $(id -u):$(id -g) $project_name"
    sudo chown -R "$USER":"$USER" "$project_name"
    echo "Ownership changed to $USER:$USER for '$project_name'."
    echo "cleaning temporary files..."
    sudo rm -rf .pnpm-store 
}

# Function to create a new NestJs project using Docker
create_nestjs_project() {
    read -p "Enter project name: " project_name
    sudo docker run --rm -v "$(pwd):/app" -w /app -it node:20.11.1-alpine sh -c "apk add --no-cache git && npm install -g pnpm @nestjs/cli && nest new $project_name && chown -R $(id -u):$(id -g) $project_name"
    sudo chown -R "$USER":"$USER" "$project_name"
    echo "Ownership changed to $USER:$USER for '$project_name'."
    echo "cleaning temporary files..."
    sudo rm -rf .pnpm-store 
}

# Function to create a new Refine.dev project using Docker
create_refine_project() {
    sudo docker run --rm -v "$(pwd):/app" -w /app -it node:20.11.1-alpine sh -c "apk add --no-cache git && npm init refine-app@latest && chown -R $(id -u):$(id -g) "
}


# Main Menu
gum style --border normal --margin "1" --padding "1 2" --border-foreground 12 "Hello, there! Welcome to $(gum style --foreground 12 'DockerWizard')."

echo "What do you want to do?"
CHOICE=$(gum choose --item.foreground 250 "Create a new Laravel project" "Create a new Nuxt.Js project" "Create a new NestJs project" "Create a new Refine.dev project" "Quit")

if [[ "$CHOICE" == "Create a new Laravel project" ]]; then
    sleep 1; clear
    create_laravel_project 
elif [[ "$CHOICE" == "Create a new Nuxt.Js project" ]]; then
    sleep 1; clear
    create_nuxt_project 
elif [[ "$CHOICE" == "Create a new NestJs project" ]]; then
    sleep 1; clear
    create_nestjs_project 
elif [[ "$CHOICE" == "Create a new Refine.dev project" ]]; then
    sleep 1; clear
    create_refine_project 
elif [[ "$CHOICE" == "Quit" ]]; then
    echo "Exiting..."; exit
fi
