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
  handlers = {
    ["textDocument/publishDiagnostics"] = function (err, result, ctx, config)
      if result and result.diagnostics then
        for _, diagnostic in ipairs(result.diagnostics) do
          -- Psalm suele enviar tags como userdata/null en 0.12
          if diagnostic.tags and type(diagnostic.tags) ~= "table" then
            diagnostic.tags = {}
          end
        end
      end
      vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
    end,
  },
  --workspace_required = true,
}
