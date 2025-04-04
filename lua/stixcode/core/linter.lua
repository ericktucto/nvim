local linter = require("lint")
linter.linters_by_ft = {
  php = {
    "phpstan",
    "tlint",
    "php"
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
