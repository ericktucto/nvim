local linter = require("lint")

-- CONFIG PHPCS
local phpcs_rules = vim.fn.stdpath("config") .. "/lib/phpcs/phpcs.xml"
local phpcs = require("lint").linters.phpcs
phpcs.cmd = vim.fn.stdpath("config") .. "/lib/phpcs/vendor/bin/phpcs"
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
