vim.o.termguicolors = true
vim.o.cursorline = true
vim.wo.wrap = false
vim.o.wrap = false
vim.o.emoji = true
vim.wo.colorcolumn = '80'
vim.o.colorcolumn = '80'
vim.cmd.colorscheme("catppuccin")

-- cursor style
vim.opt.guicursor = 'n-v-c:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor,a:blinkon100'

local function hiCursor()
  vim.api.nvim_set_hl(0, "Cursor", {fg='#cc9900', bg='#339966'})
  vim.api.nvim_set_hl(0, "CursorReset", {fg='white', bg='white'})
end

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = hiCursor,
  })

local function resetHi()
  vim.opt.guicursor = 'a:ver25-CursorReset,a:blinkon100'
end

vim.api.nvim_create_autocmd("VimLeave", {
  pattern = "*",
  callback = resetHi,
})
