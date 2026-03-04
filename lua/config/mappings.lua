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

-- RUN TESTING MY CONFIG NEOVIM USING PLENARY OR TESTING USING NEOTEST ON MY PROJECTS
local function run_test()
  if vim.bo.filetype == 'php' then
    require("neotest").run.run(vim.fn.expand("%"))
    return
  end
  local full_path = vim.fn.expand("%:p")
  local content_file = vim.fn.readfile(full_path)
  local tempfile = vim.fn.tempname()
  -- insert lines to tempfile
  vim.fn.writefile(content_file, tempfile)
  require('plenary.test_harness').test_file(tempfile)
end
map("n", "<Leader>t", run_test)

-- TESTING USING NEOTEST ON MY PROJECTS
-- @todo terminate function
local function run_all_test()
  if vim.bo.filetype == 'php' then
    require("neotest").run.run(vim.fn.expand("%"))
    return
  end
end
map("n", "<Leader>T", run_all_test)
