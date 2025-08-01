return {
  cmd = { 'phpactor', 'language-server' },
  filetypes = { 'php' },
  root_markers = {
    "composer.json",
    ".phpactor.json",
    ".phpactor.yml",
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
