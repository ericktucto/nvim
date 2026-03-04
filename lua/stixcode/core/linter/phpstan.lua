local linter = require("lint")

local data_path = vim.fn.stdpath("data")

local project_directory = vim.fn.getcwd()

local phpstan_bin = 'phpstan'

if vim.fn.executable(project_directory .. '/vendor/bin/phpstan') == 1 then
  phpstan_bin = project_directory .. '/vendor/bin/phpstan'
end

local phpstan = linter.linters.phpstan
phpstan.cmd = phpstan_bin
--phpstan.args = { "analyse", "--error-format=json", "--no-progress", "--level=9", "src" }
