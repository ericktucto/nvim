local evt = require("stixcode.lsp.events")

evt.on_attach("phpactor", function ()
  local dap = require("dap")
  dap.adapters.php = {
    type = 'executable',
    command = 'php-debug-adapter',
  }

  dap.configurations.php = {
    {
      type = 'php',
      request = 'launch',
      name = 'Listen for Xdebug',
      port = 9003
    }
  }
end)
