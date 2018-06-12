#!/usr/bin/env bash

current_dir=$(printf '%q\n' "${PWD##*/}")

# Commands
key="$1"
if [ $1 ]
    then
        shift
fi

case $key in
    -b|build)
        docker build -t grunt .
    ;;
    bootstrap)
        docker run --name "grunt_$current_dir" --rm -v "$PWD":/usr/src/project -w /usr/src/project grunt npm install
    ;;
    -g|grunt)
        cmd=${@:-build}
        docker run --name "grunt_$current_dir" --rm -p1337:1337 -v "$PWD":/usr/src/project -w /usr/src/project grunt grunt $cmd
    ;;
    -n|npm)
        cmd=${@}
        docker run --name "grunt_$current_dir" --rm -p1337:1337 -v "$PWD":/usr/src/project -w /usr/src/project grunt npm $cmd
    ;;
    *)
    ;;
esac