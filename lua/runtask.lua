local utils = require("runtask.utils")
local pasync = require("plenary.async")
local Job = require("plenary.job")

--- @alias Runtask.Output.Type "json" | "plain"

--- @class (exact) Runtask.Output.Output
--- @field type Runtask.Output.Type
--- @field content string[]

--- @class (exact) Runtask.Config
--- @field on_start? fun()
--- @field on_exit? fun(output: Runtask.Output.Output)

local M = {
  on_start = function () end,
  on_exit = function () end,
}

local default_options = {
  on_start = function () end,
  on_exit = function () end,
}

--- @return bool, string
local function is_json(json)
  local decoded = ""
  local _getMessage = function ()
    decoded = vim.json.decode(json)
    return true
  end

  if pcall(_getMessage) then
    return false, decoded
  end
  return true, json
end


local function request()
  local root = vim.fn.getcwd()
  M.on_start()
  ---@diagnostic disable-next-line
  Job:new({
    command = "bash",
    args = { root .. "/exec.sh" },
    on_exit = function (j, _)
      local output = {
        type = "plain",
        content = j:result(),
      } ---@type Runtask.Output.Output
      local result = table.concat(output.content, "")
      local err, message = is_json(result)
      if err then
        return M.on_exit(output)
      end
      output.type = "json"
      output.content = utils.dump(message)
      return M.on_exit(output)
    end
  }):start()
end

function M:run()
  ---@todo fix second parameter
  ---@diagnostic disable-next-line
  pasync.run(request)
end

---@param opts Runtask.Config
function M.setup(opts)
  opts = vim.tbl_deep_extend("keep", opts or {}, default_options)
  M.on_start = opts.on_start
  M.on_exit = opts.on_exit
end

return M
