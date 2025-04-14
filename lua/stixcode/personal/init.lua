local pasync = require("plenary.async")
local Job = require("plenary.job")
local mapper = require("common.mapper").map

local function notifySys(msg)
  io.popen("notify-send -i dialog-information '" .. msg .. "'")
end

local function dump(o, indent)
  if type(o) == 'table' then
    local s = '{\n'
    --local s = '{ '
    local spaces = string.rep(' ', indent * 2)
    for k, v in pairs(o) do
      if type(k) ~= 'number' then k = '"' .. k .. '"' end
      s = s .. spaces .. k .. ': ' .. dump(v, indent + 1) .. ',\n'
      --s = s .. '['..k..'] = ' .. dump(v) .. ','
    end
    return s .. string.rep(' ', (indent - 1) * 2) .. '}'
  else
    return tostring(o)
  end
end

--@param lines table
local function showOnPopup(lines)
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
    vim.bo[popup.bufnr].filetype = "json"
    notifySys("termino peticion")
  end)
end

local function parse(json)
  local result = dump(json, 1)
  --local result = string.gsub(dump(j, 1), "\{\\n( ){1..}\}", "\{\}")
  local lines = {}
  for s in result:gmatch("[^\r\n]+") do
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
  notifySys("iniciando peticion")
  Job:new({
    command = "bash",
    args = { "exec.sh" },
    on_exit = function (j, _)
      local json = table.concat(j:result(), "")
      vim.print(vim.inspect(json))
      local err, message = getMessage(json)
      if err then
        return showOnPopup({ message })
      end
      local dumped = dump(message, 1)
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

mapper(
  'n',
  '<Leader>m',
  function ()
    pasync.run(request)
  end
)
