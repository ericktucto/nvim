-- EXECUTABLES MASON
local psalm_bin = 'psalm'

local project_path = vim.fn.getcwd()
if vim.fn.executable(project_path .. '/vendor/bin/psalm') == 1 then
  psalm_bin = project_path .. '/vendor/bin/psalm'
end

---@type vim.lsp.Config
return {
  cmd = { psalm_bin, '--language-server' },
  filetypes = { 'php' },
  root_markers = { 'psalm.xml', 'psalm.xml.dist' },
  workspace_required = true,
}
