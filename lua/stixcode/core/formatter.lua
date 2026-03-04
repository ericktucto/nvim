local mapper = require("common.mapper").map
local personalConfig = require("stixcode.personal.config")

local config = {
  formatters_by_ft = {
    vue = { "prettier" },
    php = { "php_cs_fixer" },
  },
}

-- disable especial projects
if not vim.tbl_contains(personalConfig.except_projects, vim.fn.getcwd()) then
  config.format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  }
end

require("conform").setup(config)
mapper({ "n", "v" }, "<leader>f", function ()
  -- obtener rango del modo visual
  --local start_line, end_line = vim.fn.line("v"), vim.fn.line(".")
  require("conform").format({
    lsp_format = "fallback"
  })
end)
