local linter = require("lint")
local config_path = vim.fn.stdpath("config")

-- CONFIG PHPCS
local phpcs_rules = config_path .. "/lib/phpcs/phpcs.xml"
local phpcs_bin = config_path .. "/lib/phpcs/vendor/bin/phpcs"

local phpcs = linter.linters.phpcs
phpcs.cmd = phpcs_bin
phpcs.args = { "-q", "--standard=" .. phpcs_rules, "--report=json", "-" }

linter.linters_by_ft = {
  php = {
    "phpcs",
    "php"
  },
  sh = {
    "shellcheck",
  }
}

local lint_autgroup = vim.api.nvim_create_augroup("lint", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_autgroup,
  callback = function ()
    linter.try_lint()
  end
})

vim.keymap.set("n", "<leader>l", function ()
  linter.try_lint()
end, { desc = "Lint current buffer" })
