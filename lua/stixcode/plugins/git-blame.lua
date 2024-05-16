return {
  'f-person/git-blame.nvim',
  opts = {
    enabled = false
  },
  keys = {
    { "<Leader>b", ":GitBlameToggle<CR>", desc = "Toggle show git blame" }
  }
}
