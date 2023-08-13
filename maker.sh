#!/bin/bash

gum style --border normal --margin "1" --padding "1 2" --border-foreground 12 "Hello, there! Welcome to $(gum style --foreground 12 'DockerWizard')."
# Ask the user directory name
DIR=$(gum input --placeholder "What will be the name of the project?")

#read dir

if [[ ! -e $DIR ]]; then
    mkdir $DIR
elif [[ ! -d $DIR ]]; then
    echo "$DIR already exists but is not a directory" 1>&2
fi

echo -e "Working on it..."
sleep 1; clear

echo -e "Directory $(gum style --italic --foreground 99 $DIR) has been created.\n"

echo "What kind of project?"
CHOICE=$(gum choose --item.foreground 250 "Dockerfile" "Docker-Compose" "Devcontainer")

if [[ "$CHOICE" == "Dockerfile" ]]; then
    echo "So Dockferfile it is"
    touch "$DIR/Dockerfile"
    sleep 1; clear
    echo "What $(gum style --italic --foreground 12 "Programing Language") ?"
    LCHOICE=$(gum choose --item.foreground 250 "PHP8.1" "NodeJs")
    if [[ "$LCHOICE" == "PHP8.1" ]]; then
    paste ".stubs/PHP81.stub" "$DIR/Dockerfile" >"$DIR/Dockerfile"
    echo "Done!"
    elif [[ "$LCHOICE" == "NodeJs" ]]; then
    paste ".stubs/Node.stub" "$DIR/Dockerfile" >"$DIR/Dockerfile"
    echo "Done!"
    fi
elif [[ "$CHOICE" == "Docker-Compose" ]]; then
    echo "So Docker Compose it is"
    touch "$DIR/docker-compose.yaml"
elif [[ "$CHOICE" == "Devcontainer" ]]; then
    echo "So Devcontiner it is"
    mkdir "$DIR/.devcontainer"
    touch "$DIR/.devcontainer/Dockerfile"
    touch "$DIR/.devcontainer/docker-compose.yaml"
    touch "$DIR/.devcontainer/devcontainer.json"
fi

sleep 1; clear;

echo "Done!"