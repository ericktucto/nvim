local linter = require("lint")

local config_path = vim.fn.stdpath("config")

-- CONFIG PHPCS
local phpcs_rules = config_path .. "/lib/phpcs/phpcs.xml"
local phpcs_bin = config_path .. "/lib/phpcs/vendor/bin/phpcs"

local phpcs = linter.linters.phpcs
phpcs.cmd = phpcs_bin
phpcs.args = { "-q", "--standard=" .. phpcs_rules, "--report=json", "-" }
