#!/usr/bash

# Create npm package and repo for it on github
# usage: project test
# for private repo: project -p test
project() {
  while [[ $# -gt 0 ]]
  do
    key="$1"

    case $key in
      -p|--private)
        local private=1
        ;;
      *)
        local name="$1"
        ;;
    esac
    shift
  done

  if [ -z "$name" ]; then
    return 1
  fi

  mkdir -p ~/projects/"$name"
  cd ~/projects/"$name"
  
  if [ -d ./.git ]; then
    return 0
  fi

  hub init .
  if npm -v 2>/dev/null; then
    npm init
  fi

  if [[ $private -eq 1 ]]; then
    hub create -p $name
  else
    hub create $name
  fi
}
