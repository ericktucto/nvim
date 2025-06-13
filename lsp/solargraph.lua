return {
  cmd = { "solargraph", "stdio" },
  filetypes = { "ruby" },
  root_markers = { ".git", "Gemfile", },
  settings = {
    solargraph = {
      diagnostics = true,
      formatting = true,
      completion = true,
      hover = true,
      references = true,
      symbols = true,
      workspace = true,
    },
  },
}
