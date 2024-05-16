local mapper = require("common.mapper").mapper

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
