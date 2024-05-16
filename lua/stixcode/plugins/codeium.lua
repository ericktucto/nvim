return {}
--[[
return {
  "Exafunction/codeium.nvim",
  event = 'BufEnter',
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "onsails/lspkind.nvim",
  },
  config = function()
    require("codeium").setup({})
    --[[
    require("cmp").setup({
      sources = {
        { name = "codeium" }
      },
      formatting = {
        format = require('lspkind').cmp_format({
          mode = "symbol",
          maxwidth = 50,
          ellipsis_char = '...',
          symbol_map = { Codeium = "", }
        })
      }
    })
    --]]
    -- vim.keymap.set('i', '<C-g>', function () return vim.fn['codeium#Accept']() end, { expr = true })
--[[
  end
}
--]]
