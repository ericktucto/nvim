local M = {}
M.mapper = function (mode, shortcut, command, desc)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true, desc = desc })
end
M.map = function (mode, shortcut, command)
  vim.keymap.set(mode, shortcut, command)
end
return M
