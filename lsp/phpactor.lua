-- EXECUTABLES MASON
local phpactor_bin = 'phpactor'

local project_path = vim.fn.getcwd()
if vim.fn.executable(project_path .. '/vendor/bin/phpactor') == 1 then
  phpactor_bin = project_path .. '/vendor/bin/phpactor'
end

return {
  cmd = { phpactor_bin, 'language-server', '-vvv' },
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
