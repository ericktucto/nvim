local async = require("gitsigns.async")
local git = require("common.git")
local fs = require("common.fs")
local fzf = require("fzf-lua")
local GitHunkPreviewer = require("stixcode.widgets.fzf.previewers").GitHunk

local M = {}

M.list_hunks = async.async(function ()
  local hunks = async.await(git.get_hunks())
  GitHunkPreviewer:set_hunks(hunks)
  local bufnr = vim.api.nvim_get_current_buf()
  local path = fs.relative_path(bufnr)
  fzf.fzf_exec(function (fzf_cb)
    for k, hunk in pairs(hunks) do
      fzf_cb(path .. ":" .. hunk.vend .. "@" .. k)
    end
    fzf_cb() -- EOF
  end, {
    prompt = "> ",
    fzf_opts = {
      ["--query"] = ":@"
    },
    winopts = {
      treesitter = {
        enable = true,
      },
    },
    previewer = GitHunkPreviewer,
    actions = {
      ['default'] = function (items)
        local item = items[1]
        local _, line, key = item:match("([^:]+):(%d+)@(%d+)")
        line = tonumber(line)
        key = tonumber(key)
        local hunk = hunks[key]
        if hunk.added.count > 0 then
          line = 1 + line - hunk.added.count
        end
        vim.api.nvim_win_set_cursor(0, { line, 0 })
      end
    }
  })
end)
return M
