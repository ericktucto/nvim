local info_file = require("stixcode.widgets.lualine.components.info_file")
return {
  a = { 'mode' },
  b = {
    { 'filename', path = 1, symbols = { modified = '', readonly = '' } },
    {
      'diagnostics',
      -- Table of diagnostic sources, available sources are:
      --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
      sources = { 'nvim_lsp' },
      sections = { 'error', 'warn', 'info', 'hint' },
      symbols = { error = ' ', warn = ' ', info = ' ', hint = '󰌵 ' },
      colored = true,
      update_in_insert = true,
      always_visible = false, -- Show diagnostics even if there are none.
    },
  },
  c = {
    info_file,
  },
}
