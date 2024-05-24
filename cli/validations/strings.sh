#!/usr/bin/env bash

string::check::regex() {
    checked=$(echo $1 | grep -P -o "$2")

    if [[ -n "$checked" ]]; then
        echo 1
    else
        echo 0
    fi
}


string::check::url::git() {
    regex='^(https)://(github|gitlab)\.com/(.+)/(.+)(\.git)?$'
    string::check::regex "$1" "$regex"
}

string::check::user_repo() {
    regex='^[a-zA-Z0-9\.\-_]+/[a-zA-Z0-9\.\-_]+$'
    string::check::regex "$1" "$regex"
}
