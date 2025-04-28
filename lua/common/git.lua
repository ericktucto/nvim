local async = require('gitsigns.async')
local cache = require('gitsigns.cache').cache
local Hunks = require('gitsigns.hunks')

local M = {}

--- @async
--- @param bufnr integer
--- @param target 'unstaged'|'staged'|'all'
--- @param greedy boolean
--- @return Gitsigns.Hunk.Hunk
function M.get_nav_hunks(bufnr, target, greedy)
  local bcache = assert(cache[bufnr])
  local hunks_main = bcache:get_hunks(greedy, false) or {}

  local hunks --- @type Gitsigns.Hunk.Hunk
  if target == 'unstaged' then
    hunks = hunks_main
  else
    local hunks_head = bcache:get_hunks(greedy, true) or {}
    hunks_head = Hunks.filter_common(hunks_head, hunks_main) or {}
    if target == 'all' then
      hunks = hunks_main
      vim.list_extend(hunks, hunks_head)
      table.sort(hunks, function (h1, h2)
        return h1.added.start < h2.added.start
      end)
    elseif target == 'staged' then
      hunks = hunks_head
    end
  end
  return hunks
end

M.get_hunks = async.async(function ()
  return M.get_nav_hunks(vim.api.nvim_get_current_buf(), 'all', true)
end)

return M
