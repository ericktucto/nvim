require('flutter-tools').setup({
  flutter_path = "/home/erick/apps/flutter/bin/flutter", -- o ruta completa si hace falta
  ui = { border = "rounded" },
  debugger = { enabled = true },
  widget_guides = { enabled = true },
  closing_tags = { enabled = true },
  dev_log = { enabled = true, open_cmd = "tabedit" },
  lsp = {
    color = { enabled = false },
    settings = {
      showTodos = true,
      completeFunctionCalls = true,
    },
  },
})
