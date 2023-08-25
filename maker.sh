#!/bin/bash


########Functions#####
docker_language () {
   echo "What $(gum style --italic --foreground 12 "Programing Language") ?"
    LCHOICE=$(gum choose --item.foreground 250 "PHP8.1" "NodeJs")
    if [[ "$LCHOICE" == "PHP8.1" ]]; then
    echo "What $(gum style --italic --foreground 12 "Base") ?"
    PHPCHOICE=$(gum choose --item.foreground 250 "msft" "debian")
    
    case $PHPCHOICE in
    "debian")
    echo "debian selected"
    paste ".stubs/php/php81_debian.stub" "$1/Dockerfile" >"$1/Dockerfile"
    ;;
    "msft")
    echo "msft selected"
    paste ".stubs/php/php81_msft.stub" "$1/Dockerfile" >"$1/Dockerfile"
    ;;
    *)
    echo "none"
    #paste ".stubs/php/php81_msft.stub" "$1/Dockerfile" >"$1/Dockerfile"
    ;;
    esac
    
    echo "Done!"
    elif [[ "$LCHOICE" == "NodeJs" ]]; then
    paste ".stubs/node/node18.stub" "$1/Dockerfile" >"$1/Dockerfile"
    echo "Done!"
    fi
}

compose_file(){
    envsubst < ".stubs/compose/_base.stub" > "$1/docker-compose.yml"
}

compose_services() {
    echo "What $(gum style --italic --foreground 12 "Services") do you want to add ?"
    SERVICECHOICE=$(gum choose --no-limit --item.foreground 250 "Mysql" "Redis")
    array=($SERVICECHOICE)
    for element in "${array[@]}"; do
        echo $element
        case $element in
        "Mysql")
            COMPOSESERVICES+="  mysql:
    image: mysql:5.7
    ports:
      - '3306:3306'
    environment:
      - MYSQL_ROOT_PASSWORD=secret
      - MYSQL_DATABASE=laraveldb
    volumes:
      - db-data:/var/lib/mysql:cached

"
            COMPOSEVOLUMES+="db-data:"
        ;;
        "Redis")
            COMPOSESERVICES+="  redis:
    image: redis:alpine
    ports:
      - '6379:6379'

"
        ;;
        esac
    done
    #Export variables to be available for merge
    export COMPOSESERVICES
    export COMPOSEVOLUMES
}


gum style --border normal --margin "1" --padding "1 2" --border-foreground 12 "Hello, there! Welcome to $(gum style --foreground 12 'DockerWizard')."
# Ask the user directory name
DIR=$(gum input --placeholder "What will be the name of the project?")
#PLACEHOLDER="${\localWorkspaceFolderBasename}"
#read dir
if [[ ! -e $DIR ]]; then
    mkdir $DIR
elif [[ ! -d $DIR ]]; then
    echo "$DIR already exists but is not a directory" 1>&2
fi
#export variable for future variable substitution
export DIR
#export PLACEHOLDER
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
    docker_language "$DIR"
   
#If user chooses a docker-compose: create docker-compose.yml file, and ask for services to include
elif [[ "$CHOICE" == "Docker-Compose" ]]; then
    echo "So Docker Compose it is"
    touch "$DIR/docker-compose.yml" 
    compose_services   
    compose_file "$DIR"
#If user chooses to create a devcontainer project, create the hidden devcontainer directory, 
# and ask what kind of project. [standalone, compose] to add the correct json config
elif [[ "$CHOICE" == "Devcontainer" ]]; then
    echo "So Devcontiner it is"
    mkdir "$DIR/.devcontainer"
    CONTAINERCHOICE=$(gum choose "compose" "standalone")
    if [[ "$CONTAINERCHOICE" == "compose" ]]; then
        touch "$DIR/.devcontainer/Dockerfile" #for now empty
        touch "$DIR/.devcontainer/docker-compose.yml" #for now empty
        touch "$DIR/.devcontainer/devcontainer.json"
        envsubst < ".stubs/devcontainer/_compose.stub" > "$DIR/.devcontainer/devcontainer.json"
        #envsubst '${localWorkspaceFolderBasename}' < ".stubs/devcontainer/_compose.stub" > "$DIR/.devcontainer/devcontainer.json"
        # Replace the placeholder with the original variable in the generated JSON file
        sed -i 's/LOCAL_WORKSPACE_FOLDER_BASENAME/${localWorkspaceFolderBasename}/g' "$DIR/.devcontainer/devcontainer.json"
        #GET THE DOCKERFILE LANGUAGE
        docker_language "$DIR/.devcontainer"

        compose_services
        
        compose_file "$DIR/.devcontainer"

        

    elif [[ "$CONTAINERCHOICE" == "standalone" ]]; then
        touch "$DIR/.devcontainer/Dockerfile" #for now empty: wip
        envsubst < ".stubs/devcontainer/_docker.stub" > "$DIR/.devcontainer/devcontainer.json"
         #GET THE DOCKERFILE LANGUAGE
        docker_language "$DIR/.devcontainer"
    fi
fi

#sleep 1; clear;

#echo "Done!"