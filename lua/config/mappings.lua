local mapper = function (mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true})
end

-- NAVEGAR EN EL ARCHIVO
mapper("", "<c-i>", "<c-b>")
mapper("", "<c-o>", "<c-f>")

-- QUIT NEOVIM
mapper("n", "<Leader>q", ":quit<CR>")
mapper("n", "<Leader>Q", ":quit!<CR>")

-- COPY ON CLIPBOARD SYSTEM
mapper("v", "<Leader>y", '"+y')

-- PRETTIER
-- mapper("", "<Leader>r", ":Prettier<CR>")

-- TAGBAR
mapper("", "<Leader>m", ":Vista<CR>")
mapper("i", "<Leader>m", "<Esc> :Vista<CR>")

-- QUIT TERMINAL WITH CONTROL + N
vim.cmd([[
  tnoremap <C-n> <C-\><C-n>
]])

