-- MODOS PARA LA BUSQUEDA DE ARCHIVOS EN UN PROYECTO
local preview = string.format('%s/scripts/previewer {}', vim.fn.stdpath('config'))
function Searching(view)
  if (view == 'buffer') then
    vim.fn['fzf#vim#buffers']({
        options = { '--layout=reverse' },
        window = { width = 1, height = 1 }
      })
  elseif (view == 'git-status') then
    vim.fn["fzf#run"]({
      options = { '--layout=reverse', '--preview', preview },
      window = { width = 1, height = 1 },
      source = string.format('%s/scripts/gitstatus.py', vim.fn.stdpath('config')),
      sink = "e"
    })
  end
end

function FindWord(query, fullscreen)
  local excludedDir = table.concat({
    "",
    '.git',
    'venv',
    'node_modules',
    'vendor',
    'storage',
    'public',
    'docker',
    'expo',
    'clockwork',
    'expo-shared',
    'coverage',
    'target',
    -- Cartero
    'build',
    'install',
    'run',
    -- Bulwark
    './var/cache/*',
  }, " --exclude-dir=")
  local commandSearch = "grep %s -RHonia %s . || true"
  local initial_command = string.format(commandSearch, excludedDir, "''")
  local reload_command = string.format(commandSearch, excludedDir, '{q}')

  -- local preview = string.format('%s/scripts/previewer {}', vim.fn.stdpath('config'))
  local spec = {
    options = {
      '--phony',
      '--query',
      query,
      '--bind',
      'change:reload:' .. reload_command,
      '--layout=reverse',
      '--preview',
      preview
    },
    window = { width = 1, height = 1 }
  }
  vim.fn['fzf#vim#grep'](initial_command, 1, spec, fullscreen)
end

-- ESTA FUNCION LISTA MIS PROYECTOS
function Projects()
  coroutine.wrap(function()
    local fzf = require("fzf")
    local projects = require('project_nvim').get_recent_projects()
    local result = fzf.fzf(projects, "--ansi --layout=reverse --prompt='Elige un proyecto >>> '", { border = false })
    if result then
      require('project_nvim.project').set_pwd(result[1], "stixcode")
      vim.fn["NERDTreeCWD"]()
    else
      print("Hubo un fallo")
    end
  end)()
end
vim.cmd([[
  command! -nargs=* -bang FWord lua FindWord(<q-args>, <bang>0)
]])

local mapper = require("common.mapper").map
-- Search file
mapper('', '<c-p>', function () require('fzf-lua').files({ resume = true }) end)

-- Searching on stage (git)
-- mapper("", "<Leader>s", function() Searching('git-status') end)

-- Searching buffer
-- mapper("", "<Leader>p", function() Searching('buffer') end)

-- Search word in project
-- mapper("n", "<Leader>f", "<cmd>:FWord<CR>")

-- { "<Leader>k", "<cmd>lua Projects()<CR>", desc = "Abrir proyecto..." },
-- { "<Leader>f", "<cmd>FWord<CR>", desc = "Buscar una palabra en el proyecto" },
-- { "<Leader>f", "<Esc> :FWord<CR>", desc = "Buscar una palabra en el proyecto", mode = "i" }

