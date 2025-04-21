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
