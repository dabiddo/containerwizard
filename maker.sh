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
#export variable for future variable substitution
export DIR
echo -e "Working on it..."
sleep 1; clear

echo -e "Directory $(gum style --italic --foreground 99 $DIR) has been created.\n"

#Start project configuration wizard
echo "What kind of project?"
CHOICE=$(gum choose --item.foreground 250 "Dockerfile" "Docker-Compose" "Devcontainer")

#If user chooses to create a Docker file, ask white type of programming languange
if [[ "$CHOICE" == "Dockerfile" ]]; then
    echo "So Dockferfile it is"
    touch "$DIR/Dockerfile"
    sleep 1; clear
    echo "What $(gum style --italic --foreground 12 "Programing Language") ?"
    LCHOICE=$(gum choose --item.foreground 250 "PHP8.1" "NodeJs")
    if [[ "$LCHOICE" == "PHP8.1" ]]; then
    echo "What $(gum style --italic --foreground 12 "Base") ?"
    PHPCHOICE=$(gum choose --item.foreground 250 "alpine" "debian")

    case PHPCHOICE in
    "debian")
    paste ".stubs/php/php81_debian.stub" "$DIR/Dockerfile" >"$DIR/Dockerfile"
    ;;
    *)
    paste ".stubs/php/php81_alpine.stub" "$DIR/Dockerfile" >"$DIR/Dockerfile"
    ;;
    esac
    
    echo "Done!"
    elif [[ "$LCHOICE" == "NodeJs" ]]; then
    paste ".stubs/Node.stub" "$DIR/Dockerfile" >"$DIR/Dockerfile"
    echo "Done!"
    fi
#If user chooses a docker-compose: create docker-compose.yaml file, and ask for services to include
elif [[ "$CHOICE" == "Docker-Compose" ]]; then
    echo "So Docker Compose it is"
    touch "$DIR/docker-compose.yaml" #WIP: ask for services to include in the yaml file
#If user chooses to create a devcontainer project, create the hidden devcontainer directory, 
# and ask what kind of project. [standalone, compose] to add the correct json config
elif [[ "$CHOICE" == "Devcontainer" ]]; then
    echo "So Devcontiner it is"
    mkdir "$DIR/.devcontainer"
    CONTAINERCHOICE=$(gum choose "compose" "standalone")
    if [[ "$CONTAINERCHOICE" == "compose" ]]; then
        touch "$DIR/.devcontainer/docker-compose.yaml" #for now empty: wip
        touch "$DIR/.devcontainer/devcontainer.json"
        envsubst < ".stubs/devcontainer/_compose.stub" > "$DIR/.devcontainer/devcontainer.json"

    elif [[ "$CONTAINERCHOICE" == "standalone" ]]; then
        touch "$DIR/.devcontainer/Dockerfile" #for now empty: wip
        envsubst < ".stubs/devcontainer/_docker.stub" > "$DIR/.devcontainer/devcontainer.json"
    fi
fi

sleep 1; clear;

echo "Done!"