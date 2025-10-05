local linter = require("lint")
require("stixcode.core.linter.phpstan")
require("stixcode.core.linter.phpcs")

linter.linters_by_ft = {
  php = {
    --"phpstan",
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
