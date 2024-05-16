local wildignore = ''
local wildignored = {
  '*/tmp/*',
  '*.so',
  '*.swp',
  '*.zip',
  '*.rar',
  '*/__pycache__/*',
  'build.?/*',
  '*/.git/*',
}

for i = 1, #wildignored do
  wildignore = wildignore .. wildignored[i] .. ','
end

vim.o.wildignore = wildignore

vim.o.autoindent =  true
vim.bo.autoindent =  true

vim.o.expandtab =  true
vim.bo.expandtab =  true

vim.o.shiftwidth = 4
vim.bo.shiftwidth = 4

vim.o.softtabstop = 4
vim.bo.softtabstop = 4

vim.o.tabstop = 4
vim.bo.tabstop = 4

vim.wo.number = true
vim.o.number = true
vim.wo.relativenumber = true
vim.o.relativenumber = true

vim.o.updatetime = 100

-- vim.o.shell = "/usr/bin/xonsh"
vim.o.shell = "/usr/bin/bash"
vim.cmd([[ let mapleader = "\<C-h>" ]])
-- vim.g.mapleader = [[ "\<C-h>" ]]

vim.opt.list = true
vim.opt.listchars = { trail = '·', eol = '↴', nbsp = '%', tab = '> ' }
vim.g.python3_host_prog='/usr/bin/python3'

vim.opt.listchars["extends"] = "eol:↴"

vim.g.editorconfig = true
