return {
  'sbdchd/neoformat',
  event = { "BufReadPost", "BufNewFile" },
  keys = {
    { "<Leader>r", ":Neoformat<cr>", desc = "Prettier" },
  },
}
