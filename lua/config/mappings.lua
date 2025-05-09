local mapper = require("common.mapper").mapper
local map = require("common.mapper").map

-- NAVEGAR EN EL ARCHIVO
mapper("", "<c-i>", "<c-b>")
mapper("", "<c-o>", "<c-f>")

-- QUIT NEOVIM
mapper("n", "<Leader>q", ":quit<CR>")
mapper("n", "<Leader>Q", ":quit!<CR>")

-- COPY ON CLIPBOARD SYSTEM
mapper("v", "<Leader>y", '"+y')

-- TAGBAR
mapper("", "<Leader>m", ":SymbolsOutline<CR>")
mapper("i", "<Leader>m", "<Esc> :SymbolsOutline<CR>")

-- QUIT TERMINAL WITH CONTROL + N
vim.cmd([[
  tnoremap <C-n> <C-\><C-n>
]])

-- RUN TESTING MY CONFIG NEEOVIM USING PLENARY
local function run_test()
  local full_path = vim.fn.expand("%:p")
  local content_file = vim.fn.readfile(full_path)
  local tempfile = vim.fn.tempname()
  -- insert lines to tempfile
  vim.fn.writefile(content_file, tempfile)
  require('plenary.test_harness').test_file(tempfile)
end
map("n", "<Leader>t", run_test)

-- LSP
--[[
mapper('n', 'K', '<cmd>lua vim.lsp.buf.hover({border = vim.g.lsp_zero_border_style})<cr>', 'Hover documentation')
mapper('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help({border = vim.g.lsp_zero_border_style})<cr>',
  'Show function signature')
mapper('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', 'Go to definition')
mapper('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', 'Go to declaration')
mapper('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', 'Go to implementation')
mapper('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', 'Go to type definition')
mapper('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', 'Go to reference')
mapper('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename symbol')
mapper('n', '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', 'Format file')
mapper('x', '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', 'Format selection')
mapper('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Execute code action')
]]
