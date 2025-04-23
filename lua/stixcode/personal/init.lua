local personal = require("stixcode.personal.parser")
local pasync = require("plenary.async")
local Job = require("plenary.job")
local mapper = require("common.mapper").map
local notify = require("stixcode.personal.notify")

--@param lines table
local function showOnPopup(lines, filetype)
  if filetype == nil then filetype = "json" end
  vim.schedule(function ()
    local Popup = require("nui.popup")
    local event = require("nui.utils.autocmd").event

    local popup = Popup({
      enter = true,
      focusable = true,
      border = {
        style = "rounded",
      },
      position = "50%",
      size = {
        width = "80%",
        height = "60%",
      },
    })

    -- mount/open the component
    popup:mount()

    -- unmount component when cursor leaves buffer
    popup:on(event.BufLeave, function ()
      popup:unmount()
    end)

    -- set content
    vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, lines)
    vim.bo[popup.bufnr].filetype = filetype
    notify.simple("Termino el script")
  end)
end

--@param json string
local function parse(json)
  local lines = {}
  for s in json:gmatch("[^\r\n]+") do
    table.insert(lines, s)
  end
  return lines
end

-- @return bool, string
local function getMessage(json)
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
  notify.simple("Ejecutando script")
  Job:new({
    command = "bash",
    args = { "exec.sh" },
    on_exit = function (j, _)
      local json = table.concat(j:result(), "")
      local err, message = getMessage(json)
      if err then
        if message == "" then
          return notify.simple("Termino el script")
        end
        return showOnPopup({ message }, "markdown")
      end
      local dumped = personal.dump(message)
      local lines = parse(dumped)
      showOnPopup(lines)
    end
  }):start()
end

mapper(
  'n',
  '<Leader>o',
  function ()
    pasync.run(request)
  end
)
