local project_path = vim.fn.getcwd()
local linter = require("lint")

local php_config = { 'php' }

if
    vim.fn.executable(project_path .. '/vendor/bin/psalm') == 0 and
    vim.fn.executable(project_path .. '/vendor/bin/psalm.xml') == 0
then
  --require("stixcode.core.linter.phpstan")
  require("stixcode.core.linter.phpcs")
  --table.insert(php_config, 'phpstan')
  table.insert(php_config, 'phpcs')
end

linter.linters_by_ft = {
  php = php_config,
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
