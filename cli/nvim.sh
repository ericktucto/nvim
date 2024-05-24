#!/usr/bin/env bash
# Maintainer: Erick Tucto <erick@ericktucto.com>

string::check::url::git() {
    local regex='^(https?|git|ssh|git@)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
    if [[ $1 =~ $regex ]]; then
        return 0
    fi
    return 1
}
string::check::user_repo() {
    local regex='\w+/\w+'
    if [[ $1 =~ $regex ]]; then
        return 0
    fi
    return 1
}

add() {
    if [[ $# -eq 3 ]]; then
        local url=https://github.com/$1.git
        local path=pack/$2/start/$3
        if [[ string::check::url::git $url ]]; then
            echo "is url"
        fi
        # git submodule add $url $path

        exit 1
    fi
    echo "./nvim.sh add <user/plugin> <category>"
}

saluda() {
    echo "Hola erick"
}

if [[ $# -eq 0 ]]; then
    echo "Custom packages manager v1 - Erick Tucto"
    exit 0
fi

comando=$1

if declare -f "$comando" > /dev/null; then
    "$comando" "${@:2}"
else
    echo "Comando no reconocida"
    exit 1
fi

