local mapper = require("common.mapper").map
vim.opt.termguicolors = true
require("bufferline").setup({
  options = {
    truncate_names = false,
    offsets = {
      {
        filetype = "NvimTree",
        text = "PROYECTO",
        highlight = "Directory",
        text_align = "center"
      }
    },
    separator_style = "thin",
  }
})

local bindings = {
  -- NEXT, PREVIOUS BUFFER
  { "<c-k>",     ":bnext<CR>",            desc = "Siguiente buffer" },
  { "<c-k>",     "<Esc> :bnext<CR>i",     desc = "Siguiente buffer", mode = "i" },
  { "<c-j>",     ":bprevious<CR>",        desc = "Anterior buffer" },
  { "<c-j>",     "<Esc> :bprevious<CR>i", desc = "Anterior buffer",  mode = "i" },

  -- SAVE BUFFER
  { "<Leader>h", ":update<CR>",           desc = "Guardar buffer" },
  { "<Leader>h", "<C-C> :update<CR>",     desc = "Guardar buffer",   mode = "v" },
  -- { "<Leader>h", "<Esc> <C-O> :update<CR>", desc = "Guardar buffer", mode = "i" },
  { "<Leader>H", ":update!<CR>",          desc = "Guardar buffer" },
  { "<Leader>H", "<C-C> :update!<CR>",    desc = "Guardar buffer",   mode = "v" },
  -- { "<Leader>H", "<Esc> <C-O> :update!<CR>", desc = "Guardar buffer", mode = "i" },

  -- CLOSE BUFFER
  { "<Leader>j", ":bd<CR>",               desc = "buffer" },
  { "<Leader>j", "<C-C> :bd<CR>",         desc = "buffer",           mode = "v" },
  -- { "<Leader>j", "<Esc> <C-O> :bd<CR>", desc = "buffer", mode = "i" },
  { "<Leader>J", ":bd!<CR>",              desc = "buffer" },
  { "<Leader>J", "<C-C> :bd!<CR>",        desc = "buffer",           mode = "v" },
  -- { "<Leader>J", "<Esc> <C-O> :bd!<CR>", desc = "buffer", mode = "i" },

  -- CLOSE ALL BUFFER
  { "<Leader>u", ":%bdele<CR>",           desc = "buffer" },
  { "<Leader>u", "<C-C> :%bdele<CR>",     desc = "buffer",           mode = "v" },
  -- { "<Leader>u", "<Esc> <C-O> :%bdele<CR>", desc = "buffer", mode = "i" },
  { "<Leader>U", ":%bdele!<CR>",          desc = "buffer" },
  { "<Leader>U", "<C-C> :%bdele!<CR>",    desc = "buffer",           mode = "v" },
  -- { "<Leader>U", "<Esc> <C-O> :%bdele!<CR>", desc = "buffer", mode = "i" },
}

for _, item in pairs(bindings) do
  local bind = item[1]
  local fn = item[2]
  local mode = item.mode
  local desc = item.desc
  if mode == nil then mode = "" end
  mapper(mode, bind, fn, desc)
end
