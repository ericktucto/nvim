local M = {}
M.mapper = function (mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true})
end
M.map = function (mode, shortcut, command)
  vim.keymap.set(mode, shortcut, command)
end
return M
