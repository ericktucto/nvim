local git = require("common.git")
local fs = require("common.fs")
local fzf = require("fzf-lua")
local GitHunkPreviewer = require("stixcode.widgets.fzf.previewers").GitHunk

local M = {}

M.list_hunks = function ()
  local hunks = git.get_hunks()
  if hunks == nil then
    return
  end
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
        local _, _, key = item:match("([^:]+):(%d+)@(%d+)")
        key = tonumber(key)
        if key == nil or hunks[key] == nil then
          return
        end

        local line = hunks[key].added.start
        if line == 0 then
          line = 1
        end
        vim.api.nvim_win_set_cursor(0, { line, 0 })
      end
    }
  })
end
return M
