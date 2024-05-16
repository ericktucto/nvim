local fs = require('common.fs')
return {
  {
    'MarcHamamji/runner.nvim',
    dependencies = {
      {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' }
      },
      { 'rxi/json.lua' }
    },
    config = function()
      local runner = require('runner')
      local helpers = require('runner.handlers.helpers')
      runner.setup({})
      runner.set_handler('php', function(buffer)
        local composer_path = vim.fn.getcwd() .. '/composer.json' -- expand('%:p')

        -- emitir error cuando no existe composer.json
        if fs.exists(composer_path) == false then
          vim.print('composer.json not found')
          return nil
        end
        local composer_json = vim.json.decode(fs.read(composer_path))
        local scripts = composer_json["scripts"]

        local handlers = {}
        for k, _ in pairs(scripts) do
          local command = 'composer run-script ' .. k
          local command_docker = 'docker-compose exec php ' .. command
          handlers['(php) ' .. k] = helpers.shell_handler(command)
          handlers['(docker) ' .. k] = helpers.shell_handler(command_docker)
        end
        helpers.choice(handlers)(buffer)
      end)
    end
  }
}
