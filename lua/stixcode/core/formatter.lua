local mapper = require("common.mapper").map

local config = {
  formatters_by_ft = {
    php = { "php_cs_fixer" },
  },
}

local except_projects = {
  "/home/erick/Proyectos/Freelance/bulwarkapi",
  "/home/erick/Proyectos/Freelance/TempestFrontend",
}
-- disable especial projects
if not vim.tbl_contains(except_projects, vim.fn.getcwd()) then
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
