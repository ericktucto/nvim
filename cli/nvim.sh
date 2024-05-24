#!/usr/bin/env bash
# Maintainer: Erick Tucto <erick@ericktucto.com>

source ./validations/strings.sh

add() {
    if [[ $# -eq 3 ]]; then
        local url=$1
        if [[ -n "$(string::check::user_repo "$url")" ]]; then
            url=https://github.com/$1.git
        fi

        local path=pack/$2/start/$3

        local checked="$(string::check::url::git "$url")"
        if [[ -n "$checked" ]]; then
            # git submodule add $url $path
        fi

        exit 1
    fi
    echo "./nvim.sh add <user/plugin> <category> <name>"
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

