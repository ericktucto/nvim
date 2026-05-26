-- EXECUTABLES MASON
local bin = 'phpantom_lsp'

if vim.fn.executable('/home/erick/apps/phpantom_lsp/target/release/phpantom_lsp') == 1 then
  bin = '/home/erick/apps/phpantom_lsp/target/release/phpantom_lsp'
end

return {
  cmd = { bin },
  filetypes = { 'php' },
  root_markers = {
    "composer.json",
    ".git",
  },
  init_options = {
    ['indexer.exclude_patterns'] = {
      '/vendor/**/Tests',
      '/vendor/**/tests/**/*',
      '/vendor/composer/**/*',
      '/var/**/*',
    },
  }
}
