function set_up() {
    ROOT_DIR="$(dirname "${BASH_SOURCE[0]}")/../.."
    source "$ROOT_DIR/validations/strings.sh"
}

# data_provider urls
function test_string_is_url() {
    local url=$1
    assert_equals 1 "$(string::check::url::git "$url")"
}

function urls() {
    local uris=( \
        "https://github.com/ericktucto/nvim.git" \
        "https://github.com/ericktucto/nvim" \
        "https://gitlab.com/gabmus/vim-blueprint.git" \
        "https://gitlab.com/gabmus/vim-blueprint" \
    )
    echo "${uris[@]}"
}

# data_provider user_repos
function test_string_is_user_repo() {
    local repo=$1
    assert_equals 1 "$(string::check::user_repo "$repo")"
}

function user_repos() {
    local repos=( \
        "erick-tucto/nvim" \
        "ericktucto/nvim" \
        "ericktucto/nvim-plugin" \
        "erick-tucto/nvim-plugin" \
    )
    echo "${repos[@]}"
}

# data_provider urls
function test_string_is_not_user_repo() {
    local repo=$1
    assert_equals 0 "$(string::check::user_repo "$repo")"
}

function test_string_is_use_url_as_user_repo() {
    local repo="https://github.com/nvim-treesitter/nvim-treesitter"
    assert_equals 0 "$(string::check::user_repo "$repo")"
}
