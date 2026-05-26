local dap, ui, mapper = require "dap", require "dap-view", require "common.mapper".map

-- SIGNS
vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "🚫", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "❓", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "💬", texthl = "", linehl = "", numhl = "" })

-- UI CONFIG
ui.setup({
  windows = {
    position = "right",
  }
})
dap.listeners.after.event_stopped["ui"] = ui.open
dap.listeners.after.event_initialized["ui"] = ui.open

-- MAP KEYS
mapper("n", "<Leader>dt", dap.toggle_breakpoint, "Toggle breakpoint DAP")
mapper("n", "<Leader>dc", dap.continue, "Toggle breakpoint DAP")
mapper("n", "<Leader>dx", ui.close, "Toggle breakpoint DAP")

-- ADAPTERS
require("stixcode.core.dap.langs.php")
require("stixcode.core.dap.langs.javascript")
