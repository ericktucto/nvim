#!/usr/bin/env bash

string::check::regex() {
    checked=$(echo $1 | grep -E "$2")

    if [[ -n "$checked" ]]; then
        echo 1
    else
        echo 0
    fi
}


string::check::url::git() {
    regex='^(https)://(github|gitlab)\.com/(.+)/(.+)(\.git)?$'
    checked=$(echo $1 | grep -E "$regex")

    if [[ -n "$checked" ]]; then
        echo 1
    else
        echo 0
    fi
}

string::check::user_repo() {
    regex='^(.+)/(.+)$'
    checked=$(echo $1 | grep -E "$regex")

    if [[ -n "$checked" ]]; then
        echo 1
    else
        echo 0
    fi
}
