#!/usr/bash

if [ -n "$ZSH_VERSION" ]; then
    src=$(dirname "${(%):-%N}")/listbox/listbox.sh
elif [ -n "$BASH_VERSION" ]; then
    src=$(dirname "${BASH_SOURCE[0]}")/listbox/listbox.sh
else
    src=$(dirname "$0")/listbox/listbox.sh
fi

source "$src"

# Create npm package and repo for it on github
# usage: project test
# for private repo: project -p test
project() {
    while [[ $# -gt 0 ]]
    do
        key="$1"

        case $key in
            -h|--help)
                echo "create local repo, github repo(public or private) and initialize package"
                echo "Usage: project [options]"
                echo "Example:"
                echo "  project -p test"
                echo "Options:"
                echo "  -h, --help      help"
                echo "  -p, --private   create private github repository"
                echo "  -f, --folder    your projects folder(defaults to ~/projects)"
                echo "  -n, --no-init   avoid initializing package"
                return 0
                ;;
            -p|--private)
                local private=1
                ;;
            -f|--folder)
                local projects="$2"
                shift 1
                ;;
            -n|--no-init)
                local noinit=1
                ;;
            *)
                local name="$1"
                ;;
        esac
        shift
    done

    if [ -n "$projects" ]; then
        local projectFolder="$projects"
    elif [ -n "$PROJECTS_HOME" ]; then
        local projectFolder="$PROJECTS_HOME"
    else
        local projectFolder=~/projects
    fi

    # go to last project
    if [[ $name == "-" ]]; then
        if [[ -n "$OLDPROJECTPWD" ]]; then
            local oldProject="$OLDPROJECTPWD"

            if [[ $PWD =~ "^$projectFolder" && $PWD != "$projectFolder" ]]; then
                export OLDPROJECTPWD="$PWD"
            fi

            cd "$oldProject"

            echo -e "\n switched to project folder: $oldProject"
        else
            cd $projectFolder
        fi

        return 0
    fi

    if [ -z "$name" ]; then
        if [[ -f $projectFolder ]]; then
            echo -e "\n you already have a file called «$projectFolder»\n please specify PROJECTS_HOME variable\n see https://github.com/gko/project#projects-path\n"
        elif [[ ! -d $projectFolder ]]; then
            echo -e "\n creating and switching to «$projectFolder»\n"
            mkdir -p $projectFolder
            cd $projectFolder
        else
            echo -e "\n switching to «$projectFolder»\n"
            cd $projectFolder
        fi

        return 0
    fi

    # only for zsh since read is a bit of a mess on bash
    if [[ ! -d $projectFolder/$name &&  -n "$ZSH_VERSION" ]]; then
        echo -e ""
        read "?  «$projectFolder/$name» doesn't exist. Do you want to create it? (y/n) " answer </dev/tty

        # y or just Enter
        if ! [[ "$answer" =~ [yY] || "$answer" = "" ]]; then
            return 0;
        fi
    fi

    echo -e "\n switched to project folder: $projectFolder/$name"

    mkdir -p "$projectFolder/$name"

    if [[ $PWD =~ "^$projectFolder" && $PWD != "$projectFolder" ]]; then
        export OLDPROJECTPWD="$PWD"
    fi

    cd "$projectFolder/$name"

    if [[ -d ./.git || -f ./.git ]]; then
        return 0
    fi

    echo -e "\n  initializing repository..."
    git init .

    if [ -z $noinit ]; then
        local package=$(listbox -t "Choose package (Ctrl + C to exit):" -o "npm|cargo|gem|pip|none" | tee /dev/tty | tail -n 1)

        case "$package" in
            npm*)
                if npm -v > /dev/null 2>&1; then
                    npm init
                fi
                ;;
            cargo*)
                if cargo -V > /dev/null 2>&1; then
                    cargo init
                fi
                ;;
            gem*)
                if gem -v > /dev/null 2>&1; then
                    gem install gem-path bundler
                    local bundler=$(gem path bundler)
                    local output=$(cd ../ && "$bundler"/exe/bundle gem "$name")
                    echo "$output"
                fi
                ;;
            pip*)
                git clone https://github.com/pypa/sampleproject.git
                rm -rf ./sampleproject/.git
                mv ./sampleproject/* ./sampleproject/.git* ./
                rm -rf ./sampleproject
                ;;
            *)
        esac
    fi

    if ! gh --version > /dev/null 2>&1; then
        echo -e "\n  gh is not installed. Please refer to https://cli.github.com/"
        return 1
    fi

    if [[ $private -eq 1 ]]; then
        echo -e "\n  creating private github repository..."
        gh repo create --private $name --source=. --remote=origin
    else
        local repo=$(listbox -t "Create github repo (Ctrl + C to exit):" -o "private|public" | tee /dev/tty | tail -n 1)

        case "$repo" in
            private*)
                echo -e "\n  creating private github repository..."
                gh repo create --private $name --source=. --remote=origin
                ;;
            public*)
                echo -e "\n  creating public github repository..."
                gh repo create --public $name --source=. --remote=origin
                ;;
            *)
        esac
    fi
}
