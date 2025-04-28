local builtin = require("fzf-lua.previewer.builtin")
local M = {}

local GitHunk = builtin.base:extend()

function GitHunk:new(o, opts, fzf_win)
  GitHunk.super.new(self, o, opts, fzf_win)
  setmetatable(self, GitHunk)
  return self
end

function GitHunk:set_hunks(hunks)
  self.hunks = hunks
end

function GitHunk:populate_preview_buf(entry_str)
  local _, _, key = entry_str:match("([^:]+):(%d+)@(%d+)")
  key = tonumber(key)

  local hunk = self.hunks[key]

  local lines = {
    hunk.head,
  }
  for _, line in pairs(hunk.removed.lines) do
    table.insert(lines, "-" .. line)
  end
  for _, line in pairs(hunk.added.lines) do
    table.insert(lines, "+" .. line)
  end

  local tmpbuf = self:get_tmp_buffer()
  vim.api.nvim_buf_set_lines(tmpbuf, 0, -1, false, lines)
  vim.bo[tmpbuf].filetype = "diff"
  self:set_preview_buf(tmpbuf)
end

function GitHunk:gen_winopts()
  local new_winopts = {
    wrap   = false,
    number = false
  }
  return vim.tbl_extend("force", self.winopts, new_winopts)
end

M.GitHunk = GitHunk

return M
